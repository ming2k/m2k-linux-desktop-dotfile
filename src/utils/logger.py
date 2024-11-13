# src/utils/logger.py
import logging
from datetime import datetime
from typing import Optional

class ColoredFormatter(logging.Formatter):
    """Custom formatter adding colors to log levels."""
    
    COLORS = {
        'ERROR': '\033[31m',    # Red
        'WARNING': '\033[33m',  # Yellow
        'INFO': '\033[32m',     # Green
        'DEBUG': '\033[36m',    # Cyan
        'RESET': '\033[0m'      # Reset
    }

    def format(self, record):
        if record.levelname in self.COLORS:
            record.levelname = f"{self.COLORS[record.levelname]}{record.levelname}{self.COLORS['RESET']}"
        return super().format(record)

def setup_logger(name: Optional[str] = None) -> logging.Logger:
    """Set up and return a logger with colored output."""
    logger = logging.getLogger(name or __name__)
    
    if not logger.handlers:
        handler = logging.StreamHandler()
        formatter = ColoredFormatter(
            '[%(asctime)s] [%(levelname)s] %(message)s',
            datefmt='%Y-%m-%d %H:%M:%S'
        )
        handler.setFormatter(formatter)
        logger.addHandler(handler)
        logger.setLevel(logging.INFO)
    
    return logger
