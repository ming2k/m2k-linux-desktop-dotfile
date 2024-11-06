#!/bin/bash
# Get absolute path of script directory
BIN_DIR="$(dirname "$(readlink -f "$0")")"
PROJECT_ROOT="$(dirname "${BIN_DIR}")"
SCRIPTS_DIR="${PROJECT_ROOT}/scripts"
LIBS_DIR="${PROJECT_ROOT}/libs"
ASSETS_DIR="${PROJECT_ROOT}/assets"
BAK_HIST_DIR="${ASSETS_DIR}/bak_hist"
BACKUP_DIR="${ASSETS_DIR}/backup"

# Source the config list and log function from scripts directory
source "${LIBS_DIR}/log.sh"
source "${SCRIPTS_DIR}/config_list.sh"

# Backup function
create_backup() {

    for config in "${CONFIGS[@]}"; do
        source_dir="$config"
        config_name=$(basename "$config")
        target_dir="$BACKUP_DIR/$config_name"

        timestamp=$(date +%Y%m%d_%H%M%S)
        # If backup already exists, create timestamped backup
        if [ ! -d "$BAK_HIST_DIR" ]; then
            # if hist dir not exist, create it
            mkdir -p "${BAK_HIST_DIR}/$timestamp"
        fi
        mv "$target_dir" "${BAK_HIST_DIR}/$timestamp/"
        log "info" "Existing backup for $config_name kept in $(realpath --relative-to="$PROJECT_ROOT" "${BACKUP_DIR}/$timestamp")"
        
        if [ -d "$source_dir" ]; then
            # Create new backup
            cp -R "$source_dir" "$target_dir"
            log "info" "Backed up: $config"
        else
            log "error" "Config directory $config does not exist in $HOME/.config/, skipping"
        fi
    done

}

# Main function
main() {
    log "info" "=== Starting configuration backup ==="
    create_backup
    log "info" "=== Backup completed. ==="
}

# Run main function
main