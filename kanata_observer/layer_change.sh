#!/usr/bin/env bash

source "$HOME/.config/sketchybar/plugins/colors.sh"

bg=""
case "$1" in
"main")
  bg=$BACKGROUND_DARK
  ;;
"symb")
  bg=$BACKGROUND_DARK_ORANGE
  ;;
"symb^")
  bg=$BACKGROUND_DARK_BLUE
  ;;
"aux")
  bg=$BACKGROUND_DARK_GREEN
  ;;
"fnc")
  bg=$BACKGROUND_DARK_RED
  ;;
*)
  bg=$BACKGROUND_DARK
  ;;
esac

sketchybar --set kan label="$1" icon.color="$TEXT_WHITE" label.color="$TEXT_WHITE" background.color="$bg"
