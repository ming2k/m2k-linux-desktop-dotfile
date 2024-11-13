#!/bin/bash

SCRIPT_DIR="$(dir $(realpath "$0"))"
CONFIG_DIR="$(dir $(SCRIPT_DIR))"

mpv --force-window=no --no-terminal $(CONFIG_DIR)/assets/ring/urgency-critical.mp3
