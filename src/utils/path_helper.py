from pathlib import Path
import os
from typing import Union, Optional

def expand_path(path: Union[str, Path], relative_to: Optional[Path] = None) -> Path:
    """
    Expand a path string, handling environment variables, user home, and relative paths.
    
    Args:
        path: The path to expand
        relative_to: Optional base path for relative paths
        
    Returns:
        Path: The expanded absolute path
    """
    path_str = str(path)
    
    # 展开环境变量
    path_str = os.path.expandvars(path_str)
    
    # 展开用户目录
    path_str = os.path.expanduser(path_str)
    
    # 处理相对路径
    if not os.path.isabs(path_str) and relative_to is not None:
        path_str = os.path.join(str(relative_to), path_str)
    
    return Path(path_str).resolve()

def ensure_dir(path: Union[str, Path]) -> Path:
    """
    Ensure a directory exists, creating it if necessary.
    
    Args:
        path: The directory path to ensure
        
    Returns:
        Path: The path to the ensured directory
    """
    path = Path(path)
    path.mkdir(parents=True, exist_ok=True)
    return path

def get_project_root() -> Path:
    """
    Get the project root directory.
    
    Returns:
        Path: The absolute path to the project root
    """
    return Path(__file__).parent.parent.parent

def relative_path(path: Union[str, Path], relative_to: Union[str, Path]) -> str:
    """
    Get a path relative to another path.
    
    Args:
        path: The path to make relative
        relative_to: The reference path
        
    Returns:
        str: The relative path or original path if cannot be made relative
    """
    try:
        return str(Path(path).relative_to(Path(relative_to)))
    except ValueError:
        return str(path)

def shorten_path(path: str, max_length: int = 50) -> str:
    """
    Shorten a path string if it exceeds max_length.
    
    Args:
        path: The path to shorten
        max_length: Maximum length of the resulting string
        
    Returns:
        str: The shortened path
    """
    if len(path) <= max_length:
        return path
        
    parts = Path(path).parts
    if len(parts) <= 2:
        return path
        
    return str(Path(parts[0]) / '...' / Path(*parts[-2:]))