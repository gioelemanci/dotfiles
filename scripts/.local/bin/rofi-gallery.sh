#!/bin/bash
# =====================================================================
# ROFI HORIZONTAL WALLPAPER GALLERY (FAST CACHED VERSION)
# =====================================================================

# --- Configuration ---
WALLPAPER_DIR="$HOME/dotfiles/wallpapers/Pictures/wallpapers"
ROFI_WALL_FILE="$HOME/.config/rofi/current_wallpaper.rasi"
CACHE_DIR="$HOME/.cache/rofi_wallpapers"

# Check if directories exist
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory not found!"
    exit 1
fi

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# 1. Feed images to Rofi using thumbnails
SELECTED_FILE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | sort | while read -r img; do
    
    # Get just the filename (e.g., "mountain.jpg")
    filename=$(basename "$img")
    thumb_path="$CACHE_DIR/$filename"
    
    # If thumbnail doesn't exist, generate a tiny 300px version fast
    if [ ! -f "$thumb_path" ]; then
        magick "$img" -thumbnail 300x300^ -gravity center -extent 300x300 "$thumb_path"
    fi
    
    # Output the FULL PATH for the script to use, but show the THUMBNAIL in Rofi
    echo -en "$img\0icon\x1f$thumb_path\n"
    
done | rofi -dmenu -i -show-icons -theme ~/.config/rofi/gallery.rasi)

# Exit if nothing was selected
if [ -z "$SELECTED_FILE" ]; then
    exit 0
fi

# =====================================================================
# APPLY WALLPAPER & UPDATE SYSTEM
# =====================================================================

# 1. Apply wallpaper
awww img "$SELECTED_FILE" --transition-type wipe --transition-step 30 --transition-fps 60

# 2. Copy for Hyprlock
cp "$SELECTED_FILE" /tmp/current_wallpaper.png

# 3. Generate Pywal colors
wal -i "$SELECTED_FILE" -s &

# 4. Reload Waybar
~/.local/bin/waybar-launch.sh
