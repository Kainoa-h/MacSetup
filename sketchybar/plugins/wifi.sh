#!/bin/bash

if [ "$SENDER" = "wifi_change" ] || [ "$SENDER" = "forced" ]; then
    haswifi="󰄍"
    nohasnowifi=""
    PRIV_IPADDR="$(networksetup -getinfo Wi-Fi | grep "IP address" | head -n 1 | awk -F ':' '{print $2}')" # 0.0.0.0 | none
    PUB_IPADDR=""
    icon=""
    lbl=""
    if [ "$PRIV_IPADDR" != " none" ]; then
        icon="$haswifi"
        lbl="$PRIV_IPADDR"
        PUB_IPADDR="$(curl https://ipinfo.io/ip)"
    else
        icon="$nohasnowifi"
    fi

    sketchybar --set wifi icon="$icon"\
        --set wifi.priv.addr label="$lbl" \
        --set wifi.pub.addr label=" $PUB_IPADDR"

elif [ "$SENDER" == "mouse.entered" ]; then
    sketchybar --set wifi popup.drawing=on
elif [ "$SENDER" == "mouse.exited" ]; then
    sketchybar --set wifi popup.drawing=off
fi