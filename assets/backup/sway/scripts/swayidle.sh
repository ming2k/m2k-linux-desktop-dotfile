#!/bin/bash

# close screen
swayidle -w \
    timeout 600 'swaylock -f' \
    timeout 900 'swaymsg "output * dpms off"' \
        resume 'swaymsg "output * dpms on"' \
    lock 'swaylock -f' \
    before-sleep 'swaylock -f' 

