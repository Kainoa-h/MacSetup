#!/bin/bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh
#WARN: Unused
source "$CONFIG_DIR/plugins/colors.sh"

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=$HIGHLIGHT_BACKGROUND label.color=$TEXT_WHITE icon.color=$TEXT_WHITE background.border_color=$TEXT_GREY
else
  sketchybar --set $NAME background.color=$TRANSPARENT label.color=$TEXT_GREY icon.color=$TEXT_GREY background.border_color=$TEXT_WHITE
fi
