#!/bin/bash

vol=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n1 | awk '{print $5}' | sed 's/%//')
dunstify -h string:x-canonical-private-synchronous:audio "Volume: $vol%" -h int:value:$vol
