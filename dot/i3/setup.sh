#!/bin/bash

hostname=$(hostnamectl hostname)

# Bottom bar
polybar bottom --reload &
# ibus daemon for input methods
ibus-daemon -drxR
# Swap escape and caps lock
setxkbmap -option caps:escape
# Set keyboard repeat rate
xset r rate 200 25
# Disable mouse acceleration
# xinput --set-prop 'Logitech Gaming Mouse G302' 'libinput Accel Profile Enabled' 0, 1
# Wallpaper
nitrogen --restore
# Compositor
picom --daemon

# Touchpad configuration
if [[ "$hostname" == "udon" ]]; then
  xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
  xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
fi

# NetworkManager tray icon
nm-applet &
# Notifications
dunst &
# Screenshot utility
flameshot &
# Lock screen
xss-lock --transfer-sleep-lock -- \
  betterlockscreen --lock --off 10 &
# Thunar daemon
thunar --daemon &
# Redshift daemon
redshift-gtk -l 1.35:103.8 &
