#!/bin/bash

# Check the current mute status
status=$(amixer get Capture | grep '\[on\]')

if [ -n "$status" ]; then
    # If it's not empty, the microphone is unmuted, so mute it
    amixer set Capture nocap
    echo "Microphone muted"
else
    # If it's empty, the microphone is muted, so unmute it
    amixer set Capture cap
    echo "Microphone unmuted"
fi

