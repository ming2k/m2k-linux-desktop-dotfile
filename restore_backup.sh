#!/bin/bash

# Source the config list
source ./config_list.sh

# Restore function
restore_backup() {
    backup_dir="./config"
    timestamp=$(date +%Y%m%d_%H%M%S)

    for config in "${configs[@]}"; do
        source_dir="$backup_dir/$config"
        target_dir="$HOME/.config/$config"

        if [ -d "$source_dir" ]; then
            if [ -d "$target_dir" ]; then
                # Rename existing config
                mv "$target_dir" "${target_dir}_old_$timestamp"
                echo "Existing $config config backed up to ${target_dir}_old_$timestamp"
            fi

            # Restore from backup
            cp -R "$source_dir" "$HOME/.config/"
            echo "Restored: $config"
        else
            echo "Warning: Backup for $config does not exist, skipping"
        fi
    done

    echo "Restore completed. Old configs are renamed with '_old_$timestamp' suffix."
}

# Main function
main() {
    echo "Starting configuration restore..."
    restore_backup
}

# Run main function
main
