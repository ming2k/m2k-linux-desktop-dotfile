# Dotfiles Backup Tool

[中文](README-zh.md)

A simple tool to backup and restore configuration files for Linux applications, specifically designed for Sway WM and related tools.

## Directory Structure

```
.
├── assets/
│   ├── backup/          # Latest configuration backups
│   └── bak_hist/        # Historical backup archives
├── bin/
│   ├── backup_config.sh # Backup script
│   └── restore_backup.sh # Restore script
├── libs/
│   └── log.sh          # Logging utilities
└── scripts/
    └── config_list.sh  # Configuration path definitions
```

## Supported Configurations

- Alacritty
- Fontconfig
- Kitty
- Sway
  - Main config
  - Appearance settings
  - Keybindings
  - Monitor configuration
  - Window rules
  - Custom scripts
- Swaylock
- Waybar
  - Configuration
  - Custom scripts
  - Styling

## Prerequisites

- Linux system
- Bash shell
- The configurations you want to backup should be in their default locations in `~/.config/`

## Usage

### Backup

To backup your configurations:

```bash
./bin/backup_config.sh
```

This will:
- Create backups in `assets/backup/`
- Move existing backups to `assets/bak_hist/` with timestamps

### Restore

To restore your configurations:

```bash
./bin/restore_backup.sh
```

This will:
- Restore configurations from `assets/backup/` to their original locations
- Create parent directories if they don't exist

## Adding New Configurations

1. Edit `scripts/config_list.sh`
2. Add the path to your configuration directory

## License

[MIT License](LICENSE)