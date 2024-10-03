# Dotfiles Backup and Restore

This repository contains scripts for backing up and restoring personal configuration files (dotfiles) and font settings on a Linux system.

## Features

- Backs up and restores user-specific configuration files
- Handles font configurations and caches
- Supports Git repositories within configuration directories
- Manages system-level font configurations (requires sudo privileges)

## Components

1. `config_list.sh`: Defines the list of configurations to backup and restore
2. `backup_config.sh`: Script for creating backups
3. `restore_config.sh`: Script for restoring backups

## Usage

### Backup

To create a backup of your configurations:

```bash
./backup_config.sh
