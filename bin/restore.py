#!/usr/bin/env python3
import argparse
import sys
from pathlib import Path

# Add project root to Python path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.restore import RestoreManager
from src.config import Config
from src.utils.logger import setup_logger

logger = setup_logger(__name__)

def parse_args():
    parser = argparse.ArgumentParser(
        description="Restore configuration files from backup"
    )
    parser.add_argument(
        "-c", "--config",
        help="Path to config file (default: config/backup_list.toml)",
        type=str
    )
    parser.add_argument(
        "--dry-run",
        help="Show what would be done without making any changes",
        action="store_true"
    )
    parser.add_argument(
        "-s", "--selective",
        help="Restore only specified configurations (comma-separated)",
        type=str
    )
    parser.add_argument(
        "-v", "--verbose",
        help="Enable verbose logging",
        action="store_true"
    )
    parser.add_argument(
        "-l", "--list",
        help="List available configurations and exit",
        action="store_true"
    )
    return parser.parse_args()

def main():
    args = parse_args()
    
    try:
        config = Config(args.config)
        
        if args.list:
            print(config.list_configs())
            return 0
            
        if not config.validate():
            logger.error("Configuration validation failed")
            return 1
            
        selective = args.selective.split(',') if args.selective else None
        
        manager = RestoreManager(config)
        success = manager.restore(
            dry_run=args.dry_run,
            selective=selective
        )
        
        return 0 if success else 1
        
    except Exception as e:
        logger.error(f"Restore failed: {e}")
        return 1

if __name__ == "__main__":
    sys.exit(main())