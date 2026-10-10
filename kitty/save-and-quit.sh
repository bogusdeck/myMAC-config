#!/usr/bin/env bash
# Dump current kitty state
kitty @ ls > ~/.kitty-dump.json

# Convert to kitty session format
python3 ~/.config/kitty/kitty-save-session/kitty-convert-dump.py < ~/.kitty-dump.json > ~/.kitty-session.conf

# Quit kitty
kitty @ action quit
