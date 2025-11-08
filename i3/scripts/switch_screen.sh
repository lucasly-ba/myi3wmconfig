#!/usr/bin/env bash
xrandr=/run/current-system/sw/bin/xrandr
laptop="eDP-1"
hdmi="HDMI-1"
STATUS_FILE="/tmp/screen_status"

# lire l'état précédent (si le fichier n'existe pas, par défaut HDMI)
if [ -f "$STATUS_FILE" ]; then
    SCREEN_STATUS=$(cat "$STATUS_FILE")
else
    SCREEN_STATUS="HDMI"
fi

if [ "$SCREEN_STATUS" = "HDMI" ]; then
    # bascule sur laptop
    $xrandr --output $hdmi --off --output $laptop --auto --primary
    echo "LAPTOP" > "$STATUS_FILE"
else
    # bascule sur HDMI
    $xrandr --output $laptop --off --output $hdmi --auto --primary
    echo "HDMI" > "$STATUS_FILE"
fi

sleep 5
~/.config/polybar/launch.sh
