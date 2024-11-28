#!/bin/sh

haswifi="󰄍"
nohasnowifi=""
IPADDR="$(networksetup -getinfo Wi-Fi | grep "IP address" | head -n 1 | awk -F ':' '{print $2}')" # 0.0.0.0 | none

icon=""
lbl=""
if [ "$IPADDR" != " none" ]; then
    icon="$haswifi"
    lbl="$IPADDR"
else
    icon="$nohasnowifi"
fi

sketchybar --set "$NAME" label="$lbl" icon="$icon"