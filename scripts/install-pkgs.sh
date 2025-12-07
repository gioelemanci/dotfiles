#!/bin/bash

PKG_FILE="pkglist.txt"

# Colors for output
GREEN="\e[32m"
YELLOW="\e[33m"
RESET="\e[0m"

echo -e "${GREEN}=== ARCH LINUX SETUP START ===${RESET}"

# 1. Update system database
echo -e "${YELLOW}[*] Updating package database...${RESET}"
sudo pacman -Sy

# 2. Ensure Base-Devel and Git are present (Prerequisites for Yay)
echo -e "${YELLOW}[*] Checking prerequisites (base-devel, git)...${RESET}"
sudo pacman -S --needed --noconfirm base-devel git

# 3. Install YAY (if not present)
if ! command -v yay &> /dev/null; then
    echo -e "${YELLOW}[*] Yay not found. Installing now...${RESET}"
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd -
    rm -rf /tmp/yay
else
    echo -e "${GREEN}[OK] Yay is already installed.${RESET}"
fi

# 4. Read packages from file
echo -e "${YELLOW}[*] Reading package list from $PKG_FILE...${RESET}"

if [ ! -f "$PKG_FILE" ]; then
    echo -e "\e[31m[ERROR] File $PKG_FILE not found!\e[0m"
    exit 1
fi

# Clean the list: remove comments (lines starting with #) and empty lines
TARGET_PACKAGES=$(grep -vE "^\s*#|^\s*$" "$PKG_FILE")

# 5. Mass Install via YAY
# Yay handles both official repos and AUR seamlessly.
# --needed skips already installed packages.
echo -e "${YELLOW}[*] Installing packages...${RESET}"
yay -S --needed --noconfirm $TARGET_PACKAGES

echo -e "${GREEN}=== INSTALLATION COMPLETE ===${RESET}"
echo "Next step: Run 'stow' to link your dotfiles."
