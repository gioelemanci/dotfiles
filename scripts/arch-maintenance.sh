#!/bin/bash

# Arch Linux Full System Maintenance Script

echo "🔄 Starting full system update and cleanup..."

# Update system packages
echo "📦 Updating system packages..."
sudo pacman -Syu --noconfirm

# Remove orphaned packages
echo "🧹 Removing orphaned packages..."
sudo pacman -Rns $(pacman -Qtdq) --noconfirm 2>/dev/null || echo "No orphaned packages to remove."

# Clean package cache
echo "🗑 Cleaning package cache..."
sudo pacman -Sc --noconfirm

# Update AUR packages (if yay is installed)
if command -v yay &> /dev/null; then
    echo "🚀 Updating AUR packages with yay..."
    yay -Syu --noconfirm
fi

echo "✅ System maintenance complete!"
