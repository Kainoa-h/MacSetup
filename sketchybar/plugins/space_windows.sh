#!/bin/bash

# Interim solution. See branch 'Space'.

for sid in $(aerospace list-workspaces --monitor 1 --empty ); do
    sketchybar --set space.$sid label=" " drawing=off
done

for sid in $(aerospace list-workspaces --monitor 1 --empty no); do
    apps=$(aerospace list-windows --workspace "$sid" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
    sketchybar --set space.$sid drawing=on

    icon_strip=" "
    if [ "${apps}" != "" ]; then
        while read -r app; do
            icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
        done <<<"${apps}"
    else
        icon_strip=""
    fi
    sketchybar --set space.$sid label="$icon_strip"
done

if [ "$SENDER" == "aerospace_workspace_change" ]; then
  sketchybar --set space.$FOCUSED_WORKSPACE drawing=on
fi