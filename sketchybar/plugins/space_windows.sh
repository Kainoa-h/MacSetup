#!/bin/bash

if [ "$SENDER" = "aerospace_monitor_change" ]; then
  sketchybar --set space."$(aerospace list-workspaces --focused)" display="$TARGET_MONITOR"
  exit 0
fi

source "$CONFIG_DIR/plugins/colors.sh"

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  prevapps=$(aerospace list-windows --workspace "$PREV_WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  if [ "${prevapps}" != "" ]; then
    sketchybar --set space.$PREV_WORKSPACE drawing=on
    icon_strip=" "
    while read -r app; do
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
    done <<<"${prevapps}"
    sketchybar --set space.$PREV_WORKSPACE label="$icon_strip"
  else
    #WARN: this assumes monitor 1 is your main monitor
    aerospace move-workspace-to-monitor --workspace "$PREV_WORKSPACE" 1
    sketchybar --set space.$PREV_WORKSPACE drawing=off display=1
  fi
  sketchybar --set space.$PREV_WORKSPACE background.color=$TRANSPARENT label.color=$TEXT_GREY icon.color=$TEXT_GREY background.border_color=$TEXT_WHITE
  sketchybar --set space.$FOCUSED_WORKSPACE background.color=$HIGHLIGHT_BACKGROUND label.color=$TEXT_WHITE icon.color=$TEXT_WHITE background.border_color=$TEXT_GREY
else
  FOCUSED_WORKSPACE="$(aerospace list-workspaces --focused)"
fi

apps=$(aerospace list-windows --workspace "$FOCUSED_WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
sketchybar --set space.$FOCUSED_WORKSPACE drawing=on
icon_strip=" "
if [ "${apps}" != "" ]; then
  while read -r app; do
    icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
  done <<<"${apps}"
else
  icon_strip=""
fi

sketchybar --set space.$FOCUSED_WORKSPACE label="$icon_strip"
