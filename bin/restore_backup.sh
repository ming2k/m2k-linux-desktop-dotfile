#!/bin/bash

# Get absolute path of script directory
BIN_DIR="$(dirname "$(readlink -f "$0")")"
PROJECT_ROOT="$(dirname "${BIN_DIR}")"
SCRIPTS_DIR="${PROJECT_ROOT}/scripts"
LIBS_DIR="${PROJECT_ROOT}/libs"
ASSETS_DIR="${PROJECT_ROOT}/assets"
BACKUP_DIR="${ASSETS_DIR}/backup"

# Source the config list and log function from scripts directory
source "${LIBS_DIR}/log.sh"
source "${SCRIPTS_DIR}/config_list.sh"

# Restore function
restore_configs() {
    for config in "${CONFIGS[@]}"; do
        config_name=$(basename "$config")
        source_dir="${BACKUP_DIR}/${config_name}"
        target_dir="$config"

        if [ ! -d "$source_dir" ]; then
            log "error" "No backup found for $config_name"
            continue
        fi

        # Create parent directory if it doesn't exist
        mkdir -p "$(dirname "$target_dir")"
        
        # Restore the backup
        cp -R "$source_dir" "$target_dir"
        log "info" "Restored: $config_name to $target_dir"
    done
}

# Main function
main() {
    log "info" "=== Starting configuration restore ==="
    restore_configs
    log "info" "=== Restore completed ==="
}

# Run main function
main