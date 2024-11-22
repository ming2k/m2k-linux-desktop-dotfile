import shutil
from datetime import datetime
from pathlib import Path
from typing import Optional

from .config import Config
from .utils.logger import setup_logger
from .utils.path_helper import ensure_dir, relative_path

logger = setup_logger(__name__)

class BackupManager:
    """Manages the backup process for configuration files."""
    
    def __init__(self, config: Config):
        """
        Initialize backup manager.
        
        Args:
            config: Configuration instance
        """
        self.config = config
        self.timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
        self._setup_directories()
    
    def _setup_directories(self):
        """Create necessary backup directories."""
        self.backup_root = ensure_dir(self.config.backup_root)
        self.history_root = ensure_dir(self.backup_root.parent / 'backup_hist')
    
    def _backup_to_history(self, source: Path, name: str) -> Optional[Path]:
        """
        Move existing backup to history directory.
        
        Args:
            source: Source path to move
            name: Config name for history directory
            
        Returns:
            Path to history location if moved, None otherwise
        """
        if not source.exists():
            return None
            
        hist_path = self.history_root / self.timestamp / name
        ensure_dir(hist_path.parent)
        
        try:
            shutil.move(str(source), str(hist_path))
            rel_path = relative_path(hist_path, self.config.project_root)
            logger.info(f"Archived existing backup: {name} → backup_hist/{self.timestamp}")
            return hist_path
        except Exception as e:
            logger.error(f"Failed to archive {name}: {e}")
            return None
    
    def _create_backup(self, source: Path, target: Path, name: str) -> bool:
        """
        Create backup from source to target.
        
        Args:
            source: Source path to backup
            target: Target backup location
            name: Name of the configuration being backed up
            
        Returns:
            bool: True if backup successful
        """
        try:
            if source.is_dir():
                shutil.copytree(source, target, dirs_exist_ok=True)
            else:
                ensure_dir(target.parent)
                shutil.copy2(source, target)
            logger.info(f"Created backup: {name}")
            return True
        except Exception as e:
            logger.error(f"Failed to backup {name}: {e}")
            return False
    
    def backup(self, dry_run: bool = False) -> bool:
        """
        Perform backup operation for all enabled configs.
        
        Args:
            dry_run: If True, only log what would be done without making changes
            
        Returns:
            bool: True if all backups successful
        """
        logger.info("=== Starting configuration backup ===")
        if dry_run:
            logger.info("DRY RUN - No changes will be made")
        
        success = True
        for name, source, target in self.config.get_backup_pairs():
            source_path = Path(source)
            target_path = Path(target)
            
            if not source_path.exists():
                logger.error(f"Source does not exist, skipping: {name}")
                success = False
                continue
            
            logger.info(f"Processing backup: {name}")
            
            if dry_run:
                continue
            
            # 如果存在旧的备份，移动到历史目录
            if target_path.exists():
                if not self._backup_to_history(target_path, name):
                    success = False
                    continue
            
            # 创建新的备份
            if not self._create_backup(source_path, target_path, name):
                success = False
                continue
        
        status = "completed" if success else "completed with errors"
        logger.info(f"=== Backup {status} ===")
        return success