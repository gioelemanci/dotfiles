#!/bin/bash
# ===================
# UI RELOAD SCRIPT
# ===================

# 1. Kill existing instances safely
killall waybar
killall swayosd-server

# 2. Wait briefly to ensure processes are fully terminated and ports are freed
sleep 1

# 3. Relaunch applications in the background
waybar &
swayosd-server &

# Optional: Send a tiny notification to confirm success
# notify-send -t 1500 "UI Reloaded" "Waybar and SwayOSD updated"
