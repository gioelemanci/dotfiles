#!/bin/bash

# Configuration
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/Pictures/wallpapers"
INDEX_FILE="$HOME/.config/hypr/swww/.swww_index"
ROFI_WALL_FILE="$HOME/.config/rofi/current_wallpaper.rasi"

# Get list of image files
IMAGES=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort))
TOTAL=${#IMAGES[@]}

# Exit if no images found
if [ "$TOTAL" -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Read current index or default to 0
INDEX=$(cat "$INDEX_FILE" 2>/dev/null || echo 0)
NEXT_INDEX=$(( (INDEX + 1) % TOTAL ))
NEXT_WALL="${IMAGES[$NEXT_INDEX]}"

# Apply wallpaper with transition
swww img "$NEXT_WALL" --transition-type wipe --transition-step 30 --transition-fps 60

# --- UPDATE ROFI & HYPRLOCK ---
# 1. Write the Rofi config file
echo "* { current-image: url(\"$NEXT_WALL\", height); }" > "$ROFI_WALL_FILE"

# 2. Copy image for Hyprlock (blur effect)
cp "$NEXT_WALL" /tmp/current_wallpaper.png
# ------------------------------

# Generate Pywal color palette
wal -i "$NEXT_WALL"

# Save new index
echo "$NEXT_INDEX" > "$INDEX_FILE"

# Reload waybar
~/.config/waybar/launch-waybar.sh
