import os
from pathlib import Path
from typing import Dict, Optional
import tomli
from .utils.path_helper import expand_path, get_project_root
from .utils.logger import setup_logger

logger = setup_logger(__name__)

class Config:
    def __init__(self, config_path: Optional[str] = None):
        self.project_root = get_project_root()
        
        if config_path is None:
            config_path = self.project_root / 'config' / 'backup_list.toml'
        
        self.config_path = Path(config_path)
        
        try:
            with open(self.config_path, 'rb') as f:
                self.config = tomli.load(f)
        except FileNotFoundError:
            logger.error(f"Configuration file not found: {self.config_path}")
            raise
            
        self.backup_root = expand_path(self.config['backup_root'], self.project_root)
        self.configs = self._process_configs()

    def _process_configs(self) -> Dict[str, dict]:
        processed = {}
        for name, cfg in self.config['configs'].items():
            if not cfg.get('enabled', True):
                continue
                
            processed[name] = {
                'source': expand_path(cfg['source']),
                'backup': expand_path(cfg['backup'], self.backup_root),
                'desc': cfg.get('desc', ''),
                'enabled': cfg.get('enabled', True)
            }
        return processed

    def get_backup_pairs(self):
        for name, cfg in self.configs.items():
            yield name, str(cfg['source']), str(cfg['backup'])