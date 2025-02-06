#!/bin/bash
source "$CONFIG_DIR/plugins/colors.sh"

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100)
    ICON=""
    COLOUR=$TEXT_GREY
    ;;
  [6-8][0-9]) 
    ICON=""
    COLOUR=$TEXT_GREY
    ;;
  [3-5][0-9]) 
    ICON=""
    COLOUR=$TEXT_ORGANGE
    ;;
  [1-2][0-9]) 
    ICON=""
    COLOUR=$TEXT_RED
    ;;
  *) ICON=""
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" label.color=$COLOUR icon.color=$COLOUR
