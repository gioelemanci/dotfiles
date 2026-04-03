#!/bin/bash

# Configuration
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/Pictures/wallpapers"
ROFI_WALL_FILE="$HOME/.config/rofi/current_wallpaper.rasi"

# To pick a random image from the wallpaper folder, uncomment the line below and comment the next one
# WALL=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
WALL="$HOME/dotfiles/wallpapers/Pictures/wallpapers/nome_tua_immagine.jpg"

# Exit if no image found
if [ -z "$WALL" ]; then
    echo "No wallpaper found"
    exit 1
fi

# Apply wallpaper with transition
awww img "$WALL" --transition-type wipe --transition-step 30 --transition-fps 60

# --- UPDATE ROFI & HYPRLOCK ---
# 1. Write the Rofi config file
echo "* { current-image: url(\"$WALL\", height); }" > "$ROFI_WALL_FILE"

# 2. Copy image for Hyprlock (blur effect)
cp "$WALL" /tmp/current_wallpaper.png
# ------------------------------

# Generate Pywal color palette
wal -i "$WALL"
