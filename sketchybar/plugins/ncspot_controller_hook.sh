#!/usr/bin/env bash

source "$HOME/.config/sketchybar/plugins/colors.sh"
# this is triggered by the ncspot-controller service
# - NCSPOT_STATE - playing, paused, stopped, finished
# - NCSPOT_ARTIST - Artist name
# - NCSPOT_TITLE - Track title
# - NCSPOT_ALBUM - Album name

if [ "$NCSPOT_STATE" = "stopped" ] && [ -z "$NCSPOT_TITLE" ]; then
  sketchybar --set ncspot drawing=off
  exit 0
fi

if [ "$NCSPOT_STATE" = "paused" ] || [ "$NCSPOT_STATE" = "finished" ]; then
  sketchybar --set ncspot drawing=on icon.color="$TEXT_GREY" label="$NCSPOT_TITLE"
  exit 0
fi

sketchybar --set ncspot drawing=on label="$NCSPOT_TITLE" icon.color="$TEXT_SPOTIFY_GREEN"
