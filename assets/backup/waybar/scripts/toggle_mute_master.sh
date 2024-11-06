#!/bin/bash

# Check the current mute status
status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep '\[MUTED\]')

if [ -n "$status" ]; then
    # If it's not empty, the volume is muted, so unmute it
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    echo "Master volume unmuted"
else
    # If it's empty, the volume is unmuted, so mute it
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
    echo "Master volume muted"
fi

