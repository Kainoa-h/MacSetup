#!/bin/bash

#aerospace_workspace_change: tiggers when changing aerospace workspaces

#space_windows_change: triggers when windows are opened or closed

# This works fine, until an app is moved. Moving apps don't trigger space_windows_change since nothing is deleted or added.
# So the labels never get redrawn.
# Possible solutions:
#   - Fork aerospace code and add a event for 'exec-on-window-moved', similar to the current 'exec-on-workspace-change'
#   - Somehow detect app moved and do a `sketchybar --trigger`
#   - Run through all spaces and update everything, everytime frontapp changes. very stupid & cursed but it should be easy. (Current soloution)
#   - Maybe a lua refactor could fix this? Could maintain state of the json output of 'aerospace list-workspaces --monitor 1', and lazy update the diff?
#   - ^ This feels possible in bash too.

if [ "$SENDER" == "aerospace_workspace_change" ]; then
  prevapps=$(aerospace list-windows --workspace "$PREV_WORKSPACE" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
  if [ "${prevapps}" == "" ]; then
    sketchybar --set space.$PREV_WORKSPACE drawing=off
  fi

  sketchybar --set space.$FOCUSED_WORKSPACE drawing=on

elif [ "$SENDER" == "space_windows_change" ]; then
  for sid in $(aerospace list-workspaces --monitor 1 --empty ); do
      sketchybar --set space.$sid label=" "
  done

  for sid in $(aerospace list-workspaces --monitor 1 --empty no); do
      apps=$(aerospace list-windows --workspace "$sid" | awk -F'|' '{gsub(/^ *| *$/, "", $2); print $2}')
      #sketchybar --set space.$sid drawing=on

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
fi