#!/bin/bash

# Check the current mute status
status=$(amixer get Master | grep '\[on\]')

if [ -n "$status" ]; then
    # If it's not empty, the volume is unmuted, so mute it
    amixer set Master mute
    echo "Master volume muted"
else
    # If it's empty, the volume is muted, so unmute it
    amixer set Master unmute
    echo "Master volume unmuted"
fi

