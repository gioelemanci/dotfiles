#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 Starting Arch Linux System Maintenance...${NC}"

# 1. Full System Update (Repo + AUR)
# We use yay -Syu which handles both standard repos and AUR.
# We REMOVED --noconfirm here because you should always review updates before applying them.
echo -e "${YELLOW}📦 Updating System and AUR packages...${NC}"
yay -Syu

# 2. Remove Orphaned Packages (Unused dependencies)
# Checks if orphans exist first to avoid errors.
if [[ -n $(pacman -Qtdq) ]]; then
    echo -e "${YELLOW}🧹 Removing orphaned packages...${NC}"
    # yay -Yc is the cleanest way to remove unused deps
    yay -Yc --noconfirm
else
    echo -e "${GREEN}✨ No orphaned packages found.${NC}"
fi

# 3. Smart Cache Cleaning
# Keeps the last 2 versions of packages in case you need to downgrade.
# Requires 'pacman-contrib' package.
echo -e "${YELLOW}🗑 Cleaning package cache...${NC}"
if command -v paccache &> /dev/null; then
    # Keep only the last 2 versions of installed packages
    sudo paccache -r -k 2
    # Remove all versions of uninstalled packages
    sudo paccache -ruk0
    echo -e "${GREEN}✔ Cache cleaned (last 2 versions kept for safety).${NC}"
else
    # Fallback if paccache is missing
    echo -e "${RED}Warning: 'pacman-contrib' not found. Using standard cleanup.${NC}"
    echo -e "${RED}Tip: Install 'pacman-contrib' for safer cache management.${NC}"
    sudo pacman -Sc --noconfirm
fi

# 4. Clean AUR Cache (yay specific)
echo -e "${YELLOW}🗑 Cleaning AUR cache...${NC}"
yay -Sc --noconfirm

echo -e "${GREEN}✅ Maintenance complete! System is clean and up to date.${NC}"
