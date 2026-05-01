#!/bin/bash
# =====================================================================
# SET SPECIFIC OR RANDOM WALLPAPER
# =====================================================================

# --- Configuration ---
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/Pictures/wallpapers"
ROFI_WALL_FILE="$HOME/.config/rofi/current_wallpaper.rasi"

# To pick a random image from the wallpaper folder, uncomment the line below and comment the next one
# WALL=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | shuf -n 1)
WALL="$HOME/dotfiles/wallpapers/Pictures/wallpapers/nome_tua_immagine.jpg"

# Exit if no image is found
if [ -z "$WALL" ]; then
    echo "No wallpaper found"
    exit 1
fi

# Apply wallpaper with transition
awww img "$WALL" --transition-type wipe --transition-step 30 --transition-fps 60

# =====================================================================
# UPDATE ROFI, HYPRLOCK & SYSTEM COLORS
# =====================================================================

# 1. Create a lightweight thumbnail for instant Rofi loading
magick "$WALL" -resize 500x500^ -gravity center -extent 500x500 /tmp/rofi_thumb.png

# 2. Write the Rofi config file pointing to the fast thumbnail
echo "* { current-image: url(\"$HOME/.cache/rofi_thumb.png\", height); }" > "$ROFI_WALL_FILE"

# 3. Copy the original image for Hyprlock
cp "$WALL" /tmp/current_wallpaper.png

# 4. Generate Pywal color palette
wal -i "$WALL"
