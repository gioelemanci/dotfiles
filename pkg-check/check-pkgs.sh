#!/bin/bash

# Target file containing the list
FILE="pkglist.txt"

# Output colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Counter for missing packages
missing_count=0
missing_packages=""

# Check if the file exists before proceeding
if [ ! -f "$FILE" ]; then
    echo -e "${RED}Error: File '$FILE' not found!${NC}"
    exit 1
fi

echo "--- Checking packages ---"

# Read the file line by line
while read -r line; do
    # Remove leading/trailing whitespace
    line=$(echo "$line" | xargs)

    # Ignore empty lines or lines starting with # (full comments)
    if [[ -z "$line" || "$line" == \#* ]]; then
        continue
    fi

    # Extract only the first word (package name), ignoring inline comments
    pkg=$(echo "$line" | awk '{print $1}')

    # Check if package is installed (pacman -Q checks both repo and AUR packages)
    if pacman -Q "$pkg" &> /dev/null; then
        echo -e "${GREEN}[OK]${NC} $pkg is installed."
    else
        echo -e "${RED}[MISSING]${NC} $pkg NOT found!"
        ((missing_count++))
        missing_packages="$missing_packages $pkg"
    fi

done < "$FILE"

echo "------------------------------------"
if [ $missing_count -eq 0 ]; then
    echo -e "${GREEN}Great! All packages in the list are installed.${NC}"
else
    echo -e "${RED}You have $missing_count missing packages.${NC}"
    echo "You can install them using:"
    echo "yay -S $missing_packages"
fi
