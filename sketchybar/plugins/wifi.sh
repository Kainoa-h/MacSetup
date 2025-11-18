#!/usr/bin/env bash

if [ "$SENDER" = "wifi_change" ] || [ "$SENDER" = "forced" ]; then
  haswifi="󰄍"
  nohasnowifi=""
  PRIV_IPADDR="$(networksetup -getinfo Wi-Fi | grep "IP address" | head -n 1 | awk -F ':' '{print $2}')" # 0.0.0.0 | none
  SSID="$(networksetup -listpreferredwirelessnetworks en0 | sed -n '2s/^\t//p')"
  icon=""
  if [ "$PRIV_IPADDR" != " none" ]; then
    icon="$haswifi"
    PRIV_IPADDR="$PRIV_IPADDR"
    PUB_IPADDR="$(curl https://ipinfo.io/ip)"
  else
    icon="$nohasnowifi"
    PUB_IPADDR="none"
    SSID="-offline-"
  fi

  sketchybar --set wifi icon="$icon" label="$SSID" \
    --set wifi.priv.addr label="$PRIV_IPADDR" \
    --set wifi.pub.addr label=" $PUB_IPADDR"

elif [ "$SENDER" == "mouse.entered" ]; then
  sketchybar --set wifi popup.drawing=on
elif [ "$SENDER" == "mouse.exited" ]; then
  sketchybar --set wifi popup.drawing=off
fi
