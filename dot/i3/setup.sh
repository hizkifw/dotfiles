#!/bin/bash

# Swap escape and caps lock
setxkbmap -option caps:escape
# Set keyboard repeat rate
xset r rate 200 25
# Disable mouse acceleration
xinput --set-prop 'Logitech Gaming Mouse G302' 'libinput Accel Profile Enabled' 0, 1
# Wallpaper
nitrogen --restore

# NetworkManager tray icon
nm-applet &
# Notifications
dunst &
# Lock screen
xss-lock --transfer-sleep-lock -- \
  betterlockscreen --lock --off 10 &
