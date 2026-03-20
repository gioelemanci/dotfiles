#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}🔄 Starting Arch Linux System Maintenance...${NC}"

# 0. Security check: do not run as root
if [ "$EUID" -eq 0 ]; then
  echo -e "${RED}❌ Error: Do not run this script with sudo! Run it as a normal user, yay will ask for the password when needed.${NC}"
  exit 1
fi

# 1. Preventive Arch Keyring update (Prevents PGP errors)
echo -e "${YELLOW}🔑 Updating Arch Linux Keyring...${NC}"
# We use pacman with sudo here because yay might get stuck if keys are already corrupted
sudo pacman -Sy --needed archlinux-keyring || { echo -e "${RED}❌ Keyring update failed. Aborting.${NC}"; exit 1; }

# 2. Full system update (Repo + AUR)
echo -e "${YELLOW}📦 Updating System and AUR packages...${NC}"
# If this command fails, the script stops (exit 1)
yay -Su || { echo -e "${RED}❌ Update error. Maintenance aborted.${NC}"; exit 1; }

# 3. Remove orphaned packages
if [[ -n $(pacman -Qtdq) ]]; then
    echo -e "${YELLOW}🧹 Removing orphaned packages...${NC}"
    yay -Yc --noconfirm
else
    echo -e "${GREEN}✨ No orphaned packages found.${NC}"
fi

# 4. Smart cache cleaning (keeps the last 2 versions)
echo -e "${YELLOW}🗑 Cleaning package cache...${NC}"
if command -v paccache &> /dev/null; then
    sudo paccache -r -k 2
    sudo paccache -ruk0
    echo -e "${GREEN}✔ Cache cleaned (last 2 versions kept for safety).${NC}"
else
    echo -e "${RED}Warning: 'pacman-contrib' not found. Using standard cleanup.${NC}"
    echo -e "${YELLOW}Tip: Install 'pacman-contrib' for safer cache management.${NC}"
    sudo pacman -Sc --noconfirm
fi

# 5. Clean yay (AUR) cache
echo -e "${YELLOW}🗑 Cleaning AUR cache...${NC}"
yay -Sc --noconfirm

echo -e "${GREEN}✅ Maintenance complete! System is clean and up to date.${NC}"
