#!/bin/bash

if [ "$SENDER" == "mouse.entered" ]; then
  sketchybar --set ncspot popup.drawing=on
  sketchybar --set ncspot.img background.image="/tmp/ncspot-controller-cover.jpg"
elif [ "$SENDER" == "mouse.exited" ]; then
  sketchybar --set ncspot popup.drawing=off
  sketchybar --set ncspot.img background.image=""
fi
