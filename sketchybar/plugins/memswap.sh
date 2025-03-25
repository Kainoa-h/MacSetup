#!/bin/bash
source "$CONFIG_DIR/plugins/colors.sh"

DEFCOLOR=$TEXT_WHITE
ALERTCOLOR=$TEXT_RED
TOTALSWAP="$(sysctl vm.swapusage | awk '{print $4}')"

clr=""
if [ "$TOTALSWAP" != "0.00M" ]; then
  clr="$ALERTCOLOR"
else
  clr="$DEFCOLOR"
fi

sketchybar --set "$NAME" label="$TOTALSWAP" icon.color="$clr" label.color="$clr"

