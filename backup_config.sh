#!/bin/bash

# Source the config list
source ./config_list.sh

# Define programs to check
programs=(rsync sway swayidle swaylock brightnessctl grim tesseract kitty fcitx5)

# Check if programs are installed
check_programs() {
    for program in "${programs[@]}"; do
        if ! command -v "$program" &> /dev/null; then
            echo "Warning: $program is not installed"
        else
            echo "$program is installed"
        fi
    done
}

create_backup() {
    backup_dir="./config"

    # Create backup directory if it doesn't exist
    mkdir -p "$backup_dir"

    # Array to keep track of synced configs
    synced_configs=()

    for config in "${configs[@]}"; do
        if [ -e "$config" ]; then
            rsync -av --delete "$config" "$backup_dir/"
            echo "Synced: $config"
            synced_configs+=("$(basename "$config")")
        else
            echo "Warning: $config does not exist, skipping"
        fi
    done

    # Remove directories in backup that are not in the current config list
    for dir in "$backup_dir"/*; do
        if [ -d "$dir" ]; then
            dir_name=$(basename "$dir")
            if [[ ! " ${synced_configs[*]} " =~ " ${dir_name} " ]]; then
                echo "Removing obsolete backup: $dir_name"
                rm -rf "$dir"
            fi
        fi
    done

    echo "Backup completed, files synced in: $backup_dir"
}

# Main function
main() {
    echo "Checking program installation status..."
    check_programs

    echo -e "\nStarting configuration backup..."
    create_backup
}

# Run main function
main
