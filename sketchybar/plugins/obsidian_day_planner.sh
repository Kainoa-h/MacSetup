#!/bin/bash

# This is should be invoked by:
# https://github.com/Kainoa-h/obsidian-day-planner-event-exec
#

source "$PLUGIN_DIR/colors.sh"
if [[ "$DAY_PLANNER_TASK_STATUS" == "0" ]]; then
  sketchybar --set day drawing=off
  exit 0
fi

if [[ "$DAY_PLANNER_TASK_STATUS" == "1" ]]; then
  sketchybar --set day drawing=on \
    label="$DAY_PLANNER_TASK_TITLE: till ${DAY_PLANNER_TASK_TIMESTAMP: -5}" \
    icon.color="$TEXT_GREY"
  exit 0
fi

sketchybar --set day drawing=on \
  label="$DAY_PLANNER_TASK_TITLE: at ${DAY_PLANNER_TASK_TIMESTAMP:0:5}" \
  icon.color="$TEXT_ORGANGE"
