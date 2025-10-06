#!/bin/bash

# Pick a random image from the wallpaper folder
WALL=$(find ~/dotfiles/wallpapers/Pictures/wallpapers -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# Exit if no image found
if [ -z "$WALL" ]; then
    echo "No wallpaper found"
    exit 1
fi

# Apply wallpaper with transition
swww img "$WALL" --transition-type wipe --transition-step 30 --transition-fps 60

# Generate Pywal color palette
wal -i "$WALL"
