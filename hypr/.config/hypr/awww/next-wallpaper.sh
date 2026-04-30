#!/bin/bash
# =====================================================================
# NEXT WALLPAPER GENERATOR & SYSTEM MATCHER
# =====================================================================

# --- Configuration ---
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/Pictures/wallpapers"
INDEX_FILE="$HOME/.config/hypr/awww/.awww_index"
ROFI_WALL_FILE="$HOME/.config/rofi/current_wallpaper.rasi"

# Get the list of image files
IMAGES=($(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort))
TOTAL=${#IMAGES[@]}

# Exit if no images are found
if [ "$TOTAL" -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Read current index or default to 0
INDEX=$(cat "$INDEX_FILE" 2>/dev/null || echo 0)
NEXT_INDEX=$(( (INDEX + 1) % TOTAL ))
NEXT_WALL="${IMAGES[$NEXT_INDEX]}"

# Apply wallpaper with transition
awww img "$NEXT_WALL" --transition-type wipe --transition-step 30 --transition-fps 60

# =====================================================================
# UPDATE ROFI, HYPRLOCK & SYSTEM COLORS
# =====================================================================

# 1. Create a lightweight thumbnail for instant Rofi loading (Requires imagemagick)
magick "$NEXT_WALL" -resize 500x500^ -gravity center -extent 500x500 /tmp/rofi_thumb.png

# 2. Write the Rofi config file pointing to the fast thumbnail
echo "* { current-image: url(\"/tmp/rofi_thumb.png\", height); }" > "$ROFI_WALL_FILE"

# 3. Copy the original image for Hyprlock (so it can apply its own blur effect)
cp "$NEXT_WALL" /tmp/current_wallpaper.png

# 4. Generate Pywal color palette
wal -i "$NEXT_WALL" -s

# 5. Save the new index
echo "$NEXT_INDEX" > "$INDEX_FILE"

# 6. Reload Waybar to apply the new Pywal colors
~/.config/waybar/launch-waybar.sh
