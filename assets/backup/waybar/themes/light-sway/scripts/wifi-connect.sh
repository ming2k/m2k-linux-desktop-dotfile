#!/bin/bash

# Function to check if iwd service is running
check_iwd() {
    if ! systemctl is-active --quiet iwd; then
        notify-send "WiFi Error" "iwd service is not running"
        exit 1
    fi
}

# Function to get device name
get_device() {
    device=$(iwctl device list | grep -oP "wlan\d+" | head -1)
    if [ -z "$device" ]; then
        notify-send "WiFi Error" "No wireless device found"
        exit 1
    fi
    echo "$device"
}

# Function to check if WiFi is enabled
check_wifi_enabled() {
    local device=$1
    rfkill list wifi | grep -q "Soft blocked: no" && return 0
    notify-send "WiFi" "WiFi is disabled. Enabling..."
    rfkill unblock wifi
    sleep 2
    return 0
}

# Function to check current connection
check_connection() {
    local device=$1
    local current_network=$(iwctl station "$device" show | grep "Connected network" | awk '{print $3}')
    if [ -n "$current_network" ]; then
        notify-send "WiFi" "Already connected to $current_network"
        return 0
    fi
    return 1
}

# Function to scan networks
scan_networks() {
    local device=$1
    notify-send "WiFi" "Scanning for networks..."
    iwctl station "$device" scan
    sleep 3  # Give more time for scanning
}

# Function to auto-connect to known networks
auto_connect() {
    local device=$1
    local known_networks=$(iwctl known-networks list | tail -n +5 | sed '/^$/d' | awk '{print $1}')
    
    # Get list of available networks
    local available_networks=$(iwctl station "$device" get-networks | tail -n +5 | sed '/^$/d' | awk '{print $1}')
    
    # Try to connect to known networks in order of signal strength
    while IFS= read -r network; do
        if echo "$known_networks" | grep -q "^$network$"; then
            notify-send "WiFi" "Attempting to connect to known network: $network"
            iwctl station "$device" connect "$network"
            sleep 3
            
            # Check if connection was successful
            if check_connection "$device"; then
                notify-send "WiFi" "Successfully connected to $network"
                return 0
            fi
        fi
    done <<< "$available_networks"
    
    return 1
}

# Function to list networks and connect manually
list_and_connect() {
    local device=$1
    
    # Get list of networks with signal strength
    networks=$(iwctl station "$device" get-networks | tail -n +5 | sed '/^$/d' | awk '{print $1 " - Signal: " $2}')
    
    # Create menu items for wofi
    menu_items=""
    while IFS= read -r network; do
        menu_items+="$network"$'\n'
    done <<< "$networks"
    
    # Show wofi menu
    selected_network=$(echo -e "$menu_items" | wofi --dmenu --prompt "Select WiFi network:" | awk '{print $1}')
    
    if [ -n "$selected_network" ]; then
        # Check if network is known
        if iwctl known-networks list | grep -q "$selected_network"; then
            notify-send "WiFi" "Connecting to known network: $selected_network"
            iwctl station "$device" connect "$selected_network"
            sleep 3
            if check_connection "$device"; then
                notify-send "WiFi" "Successfully connected to $selected_network"
            else
                notify-send "WiFi" "Failed to connect to $selected_network"
            fi
        else
            # Get password through wofi
            password=$(wofi --dmenu --password --prompt "Enter password for $selected_network:")
            if [ -n "$password" ]; then
                notify-send "WiFi" "Attempting to connect to $selected_network"
                echo "$password" | iwctl station "$device" connect "$selected_network"
                sleep 3
                if check_connection "$device"; then
                    notify-send "WiFi" "Successfully connected to $selected_network"
                else
                    notify-send "WiFi" "Failed to connect to $selected_network"
                fi
            else
                notify-send "WiFi" "Connection cancelled"
            fi
        fi
    fi
}

# Main execution
check_iwd
device=$(get_device)

# Check if WiFi is enabled, if not, enable it
check_wifi_enabled "$device"

# Check if already connected
if ! check_connection "$device"; then
    # Scan for networks
    scan_networks "$device"
    
    # Try to auto-connect to known networks
    if ! auto_connect "$device"; then
        # If auto-connect fails, show network list
        notify-send "WiFi" "No known networks found. Please select a network."
        list_and_connect "$device"
    fi
fi
