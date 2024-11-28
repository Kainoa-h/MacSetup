#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=0xCFFF69B4 label.color=0xFFFFFFFF icon.color=0xFFFFFFFF background.border_color=0xBB352f36
else
  sketchybar --set $NAME background.color=0x00000000 label.color=0xBB352f36 icon.color=0xBB352f36 background.border_color=0xAAFFFFFF
fi