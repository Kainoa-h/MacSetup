#!/bin/bash
source "$CONFIG_DIR/plugins/colors.sh"

JSON="$(nc -U /tmp/ncspot-501/ncspot.sock </dev/null 2>/dev/null)"

# Check if the JSON is empty
if [ -z "$JSON" ]; then
  sketchybar --set ncspot drawing=off
  exit 0
fi

STATUS="$(echo "$JSON" | jq -r '.mode')"
if [ "$STATUS" = "Stopped" ] || [ "$STATUS" = "FinishedTrack" ]; then
  sketchybar --set ncspot drawing=on icon.color="$TEXT_GREY"
  exit 0
fi

STATUS="$(echo "$JSON" | jq -r '.mode.Playing')"

if [ "$STATUS" = "null" ]; then
  sketchybar --set ncspot drawing=on icon.color="$TEXT_GREY"
  exit 0
fi

TITLE="$(echo "$JSON" | jq -r '.playable.title')"
sketchybar --set ncspot drawing=on label="$TITLE" icon.color="$TEXT_SPOTIFY_GREEN"
