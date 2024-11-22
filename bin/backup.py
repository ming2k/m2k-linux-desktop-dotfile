#!/usr/bin/env python3
import argparse
import sys
from pathlib import Path

# 添加项目根目录到 Python 路径
project_root = Path(__file__).parent.parent
sys.path.insert(0, str(project_root))

from src.backup_manager import BackupManager
from src.config import Config
from src.utils.logger import setup_logger

logger = setup_logger(__name__)

def parse_args():
    parser = argparse.ArgumentParser(
        description="Backup configuration files based on config/backup_list.toml"
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
    return parser.parse_args()

def main():
    args = parse_args()
    
    try:
        config = Config(args.config)
        manager = BackupManager(config)
        success = manager.backup(dry_run=args.dry_run)
        return 0 if success else 1
    except Exception as e:
        logger.error(f"Backup failed: {e}")
        return 1

if __name__ == "__main__":
    sys.exit(main())