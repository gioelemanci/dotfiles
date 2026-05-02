#!/bin/bash

# Fetch updates (suppressing errors in case there's no connection)
official=$(checkupdates 2>/dev/null)
aur=$(yay -Qua 2>/dev/null)

# Count the lines (number of packages)
count_off=$(echo "$official" | grep -v '^$' | wc -l)
count_aur=$(echo "$aur" | grep -v '^$' | wc -l)
total=$((count_off + count_aur))

# If everything is up to date
if [ "$total" -eq 0 ]; then
    echo '{"text": "0", "tooltip": "System updated! ", "class": "updated"}'
    exit 0
fi

# Prepare the list for the tooltip (maximum 15 packages to avoid a wall of text)
list=$(echo -e "$official\n$aur" | grep -v '^$' | head -n 15)
tooltip_text="Updates: $total\n\n$list"

if [ "$total" -gt 15 ]; then
    tooltip_text="$tooltip_text\n...and others."
fi

# Escape newlines so that Waybar's JSON format reads it correctly
json_tooltip=$(echo "$tooltip_text" | awk '{printf "%s\\n", $0}' | sed 's/\\n$//')

# Print the output for Waybar
echo "{\"text\": \"$total\", \"tooltip\": \"$json_tooltip\", \"class\": \"pending\"}"
