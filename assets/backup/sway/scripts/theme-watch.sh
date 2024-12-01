#!/bin/bash

while true; do
    if [ "$(swaymsg -t get_outputs | jq '.[0].current_mode.height')" -gt 0 ]; then
        current_theme=$(gsettings get org.gnome.desktop.interface color-scheme)
        if [ "$current_theme" = "'prefer-dark'" ]; then
            cp ~/.config/alacritty/alacritty-dark.toml ~/.config/alacritty/alacritty.toml
        else
            cp ~/.config/alacritty/alacritty-light.toml ~/.config/alacritty/alacritty.toml
        fi
    fi
    sleep 2
done
