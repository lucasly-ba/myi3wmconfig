#!/usr/bin/env bash







vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -1 | tr -d '%')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes && echo 1 || echo 0)



if [[ "$vol" -eq 0 || "$mute" -eq 1 ]]; then
	echo " "
elif [ "$vol" -lt 30 ]; then
	echo " $vol%"
else
	echo "  $vol%"
fi




