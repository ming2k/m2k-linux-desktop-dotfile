#!/bin/bash

# 获取所有窗口的信息，只显示应用ID和窗口名称
windows=$(swaymsg -t get_tree --raw | jq -r '
  .. | select(.pid? and .app_id != null) | 
  {name: .name, id: .id, app_id: .app_id, workspace: (.workspace // .output)} | 
  "\(.app_id) - \(.name)|\(.id)|\(.workspace // "")"
')

# 使用 wofi 显示窗口列表并获取用户选择
selected=$(echo "$windows" | cut -d'|' -f1 | wofi --dmenu -i -p "Switch to:" --width 800 --height 500 --cache-file /dev/null)

if [ ! -z "$selected" ]; then
    # 找到完整的选中行
    full_line=$(echo "$windows" | grep "^$selected")
    
    id=$(echo "$full_line" | cut -d'|' -f2)
    workspace=$(echo "$full_line" | cut -d'|' -f3)

    # 如果工作区不为空，则切换到该工作区
    if [ ! -z "$workspace" ]; then
        swaymsg workspace "${workspace}"
    fi

    # 聚焦到选中的窗口
    swaymsg [con_id="${id}"] focus
fi
