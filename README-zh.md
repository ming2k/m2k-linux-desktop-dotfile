# 配置文件备份工具

[English](README.md)

一个简单的 Linux 应用程序配置文件备份和恢复工具，专为 Sway WM 及相关工具设计。

## 目录结构

```
.
├── assets/
│   ├── backup/          # 最新的配置备份
│   └── bak_hist/        # 历史备份存档
├── bin/
│   ├── backup_config.sh # 备份脚本
│   └── restore_backup.sh # 恢复脚本
├── libs/
│   └── log.sh          # 日志工具
└── scripts/
    └── config_list.sh  # 配置路径定义
```

## 支持的配置

- Alacritty
- Fontconfig
- Kitty
- Sway
  - 主配置
  - 外观设置
  - 快捷键
  - 显示器配置
  - 窗口规则
  - 自定义脚本
- Swaylock
- Waybar
  - 配置
  - 自定义脚本
  - 样式

## 前提条件

- Linux 系统
- Bash shell
- 需要备份的配置文件应位于默认位置 `~/.config/`

## 使用方法

### 备份

执行以下命令备份配置：

```bash
./bin/backup_config.sh
```

这将：
- 在 `assets/backup/` 创建备份
- 将现有备份移动到 `assets/bak_hist/` 并添加时间戳

### 恢复

执行以下命令恢复配置：

```bash
./bin/restore_backup.sh
```

这将：
- 从 `assets/backup/` 恢复配置到原始位置
- 如果需要，创建父目录

## 添加新配置

1. 编辑 `scripts/config_list.sh`
2. 添加配置目录的路径

## 许可证

[MIT License](LICENSE)