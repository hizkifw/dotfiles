#!/bin/bash

# ibus daemon for input methods
ibus-daemon -drxR
# Swap escape and caps lock
setxkbmap -option caps:escape
# Set keyboard repeat rate
xset r rate 200 25
# Disable mouse acceleration
xinput --set-prop 'Logitech Gaming Mouse G302' 'libinput Accel Profile Enabled' 0, 1
# Wallpaper
nitrogen --restore
# Compositor
picom --daemon

# NetworkManager tray icon
nm-applet &
# Notifications
dunst &
# Screenshot utility
flameshot &
# Lock screen
xss-lock --transfer-sleep-lock -- \
  betterlockscreen --lock --off 10 &
# EasyEffects
easyeffects --gapplication-service &
# Thunar daemon
thunar --daemon &
