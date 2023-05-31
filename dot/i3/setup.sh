#!/bin/bash

hostname=$(hostnamectl hostname)

# Screen layout
if [[ "$hostname" == "kotatsu" ]]; then
  xrandr \
    --output HDMI-1 \
      --mode 1920x1080 \
      --pos 0x0 \
      --rotate normal \
      --set "Broadcast RGB" "Full" \
    --output HDMI-3 \
      --primary \
      --mode 1920x1080 \
      --pos 1920x0 \
      --rotate normal \
      --set "Broadcast RGB" "Full"
fi

# Run background processes using systemd
daemonize() {
  systemd-run --user -p Restart=on-failure --collect $@
}

# Bottom bar
daemonize polybar bottom --reload
# ibus daemon for input methods
daemonize ibus-daemon --replace --xim --restart
# Swap escape and caps lock
setxkbmap -option caps:escape
# Set keyboard repeat rate
xset r rate 200 25
# Disable mouse acceleration
# xinput --set-prop 'Logitech Gaming Mouse G302' 'libinput Accel Profile Enabled' 0, 1
# Wallpaper
nitrogen --restore
# Compositor
daemonize picom --dbus

# Touchpad configuration
if [[ "$hostname" == "udon" ]]; then
  xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Natural Scrolling Enabled" 1
  xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
fi

# NetworkManager tray icon
daemonize nm-applet
# Notifications
daemonize dunst
# Listen for notifications from dbus
daemonize systembus-notify
# Screenshot utility
daemonize flameshot
# Lock screen
daemonize xss-lock --transfer-sleep-lock -- \
  betterlockscreen --lock --off 10
# Redshift daemon
daemonize redshift-gtk -l 1.35:103.8
# Automount
daemonize udiskie
# Thunar daemon
thunar --daemon &
