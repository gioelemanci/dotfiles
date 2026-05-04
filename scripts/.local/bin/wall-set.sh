#!/bin/bash
# =====================================================================
# SET RANDOM WALLPAPER
# =====================================================================

# --- Configuration ---
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/Pictures/wallpapers"

# Pick a random image from the wallpaper folder
WALL=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)

# Exit if no image is found
if [ -z "$WALL" ]; then
    echo "No wallpaper found"
    exit 1
fi

# Apply wallpaper with transition
awww img "$WALL" --transition-type wipe --transition-step 30 --transition-fps 60

# =====================================================================
# UPDATE HYPRLOCK & SYSTEM COLORS
# =====================================================================

# 1. Copy the original image for Hyprlock
cp "$WALL" /tmp/current_wallpaper.png

# 2. Generate Pywal color palette
wal -i "$WALL" -s

# 3. Reload ui
~/.local/bin/ui-reload.sh
