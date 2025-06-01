#!/bin/bash
source "$PLUGIN_DIR/colors.sh"

JSON="$(nc -U /tmp/ncspot-501/ncspot.sock </dev/null 2>/dev/null)"

# Check if the JSON is empty
if [ -z "$JSON" ]; then
  sketchybar --set ncspot drawing=false
  exit 0
fi

sketchybar --set ncspot drawing=true

STATUS="$(echo "$JSON" | jq -r '.mode.Playing')"

if [ "$STATUS" = "null" ]; then
  sketchybar --set ncspot icon.color="$TEXT_GREY"
  exit 0
fi

TITLE="$(echo "$JSON" | jq -r '.playable.title')"
sketchybar --set ncspot label="$TITLE" icon.color="$TEXT_SPOTIFY_GREEN"
