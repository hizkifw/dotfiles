#!/bin/bash

vol=$(pactl get-sink-volume 0 | head -n1 | awk '{print $5}' | sed 's/%//')
dunstify -h string:x-canonical-private-synchronous:audio "Volume: $vol%" -h int:value:$vol
