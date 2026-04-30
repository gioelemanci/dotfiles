#!/bin/bash
# =====================================================================
# ROFI VISUAL WALLPAPER GALLERY
# =====================================================================

WALLPAPER_DIR="$HOME/dotfiles/wallpapers/Pictures/wallpapers"
ROFI_WALL_FILE="$HOME/.config/rofi/current_wallpaper.rasi"

# 1. Check if the wallpaper directory exists
if [ ! -d "$WALLPAPER_DIR" ]; then
    notify-send "Error" "Wallpaper directory not found!"
    exit 1
fi

# 2. Read files and format them for Rofi (Text \0icon\x1fImagePath)
# Also injects CSS directly to create a 4-column visual grid layout
SELECTED_FILE=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \) | while read -r img; do
    echo -en "$(basename "$img")\0icon\x1f$img\n"
done | rofi -dmenu -i -show-icons -p "🖼️ Wallpapers" -theme-str '
    window { width: 60%; height: 60%; }
    listview { columns: 4; lines: 3; flow: horizontal; spacing: 20px; }
    element { orientation: vertical; padding: 10px; border-radius: 15px; }
    element-icon { size: 10em; }
    element-text { horizontal-align: 0.5; padding: 5px 0 0 0; }')

# 3. If an image was successfully selected
if [ -n "$SELECTED_FILE" ]; then
    FULL_PATH="$WALLPAPER_DIR/$SELECTED_FILE"
    
    # Apply the wallpaper
    awww img "$FULL_PATH" --transition-type wipe --transition-step 30 --transition-fps 60
    
    # Create a fast thumbnail for the main Rofi menu
    magick "$FULL_PATH" -resize 500x500^ -gravity center -extent 500x500 /tmp/rofi_thumb.png
    
    # Update Rofi and Hyprlock configs
    echo "* { current-image: url(\"/tmp/rofi_thumb.png\", height); }" > "$ROFI_WALL_FILE"
    cp "$FULL_PATH" /tmp/current_wallpaper.png
    
    # Generate Pywal colors in the background to avoid freezing the script
    wal -i "$FULL_PATH" -s &
    
    # Reload Waybar to apply the new colors
    ~/.config/waybar/launch-waybar.sh
fi
