import shutil
from pathlib import Path
from typing import Optional

from .config import Config
from .utils.logger import setup_logger
from .utils.path_helper import ensure_dir

logger = setup_logger(__name__)

class RestoreManager:
    """Manages the restore process for configuration files."""
    
    def __init__(self, config: Config):
        """
        Initialize restore manager.
        
        Args:
            config: Configuration instance
        """
        self.config = config
    
    def _restore_single(self, source: Path, target: Path) -> bool:
        """
        Restore single configuration from backup.
        
        Args:
            source: Source backup path
            target: Target restore location
            
        Returns:
            bool: True if restore successful
        """
        try:
            if source.is_dir():
                shutil.copytree(source, target, dirs_exist_ok=True)
            else:
                ensure_dir(target.parent)
                shutil.copy2(source, target)
            return True
        except Exception as e:
            logger.error(f"Failed to restore {source} to {target}: {e}")
            return False
    
    def restore(self, dry_run: bool = False, selective: Optional[list[str]] = None) -> bool:
        """
        Perform restore operation for configurations.
        
        Args:
            dry_run: If True, only log what would be done without making changes
            selective: Optional list of config names to restore, None for all
            
        Returns:
            bool: True if all restores successful
        """
        logger.info("=== Starting configuration restore ===")
        if dry_run:
            logger.info("DRY RUN - No changes will be made")
        
        success = True
        for name, target, source in self.config.get_backup_pairs():
            if selective and name not in selective:
                continue
                
            source_path = Path(source)
            target_path = Path(target)
            
            if not source_path.exists():
                logger.error(f"Backup not found, skipping: {source}")
                success = False
                continue
            
            logger.info(f"Processing restore: {name}")
            logger.debug(f"  Source: {source_path}")
            logger.debug(f"  Target: {target_path}")
            
            if dry_run:
                continue
            
            if not self._restore_single(source_path, target_path):
                success = False
                continue
                
            logger.info(f"Successfully restored: {name}")
        
        status = "completed" if success else "completed with errors"
        logger.info(f"=== Restore {status} ===")
        return success
