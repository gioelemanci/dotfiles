#!/bin/bash

# Your reference file
LIST_FILE="pkglist.txt"

# Colors
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if the file exists
if [ ! -f "$LIST_FILE" ]; then
    echo -e "${RED}Error: '$LIST_FILE' not found!${NC}"
    exit 1
fi

echo "--- Checking for packages installed on system but NOT in $LIST_FILE ---"

# Get list of explicitly installed packages (Native + AUR)
# pacman -Qqe lists only packages you installed yourself
system_packages=$(pacman -Qqe)

found_new=0

for pkg in $system_packages; do
    # Search for the package in pkglist.txt
    # We use grep with regex to ensure exact matches at the start of the line
    # ^$pkg -> Starts with package name
    # ([[:space:]]|$) -> Followed by a space OR end of line (prevents matching partial names)
    
    if ! grep -qE "^$pkg([[:space:]]|$)" "$LIST_FILE"; then
        echo -e "${RED}[UNLISTED]${NC} $pkg"
        ((found_new++))
    fi
done

echo "----------------------------------------------"
if [ $found_new -eq 0 ]; then
    echo "Perfect sync! Your file contains every explicitly installed package."
else
    echo "Found $found_new packages installed on your system but missing from the file."
fi
