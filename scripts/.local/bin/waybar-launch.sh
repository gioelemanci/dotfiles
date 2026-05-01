#!/bin/bash

# Kill any running Waybar instances
killall waybar

# Wait briefly to avoid conflicts
sleep 1

# Launch Waybar in the background
waybar &

# Confirmation message
echo "Waybar started!"
