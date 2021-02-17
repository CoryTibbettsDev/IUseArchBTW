#!/bin/bash

# Installs a more minimal version of my system for virtual machines
# Included extra development packages

PKGS=(
	# Xserver windowing
	xorg
	xorg-xinit
	# Window Manager
	xmonad
	xmonad-contrib
	xmobar # xmonad status bar
	# Run prompt
	dmenu
	# Utilities
	git
	# Wallpaper manager
	nitrogen
	# Terminal emulator
	termite
	# Web browser
	epiphany
	# Audio control
	alsa
	alsa-utils
	# GUI file browser
	pcmanfm
	# Development
	nodejs
	npm
)

echo "--Installing Packages--"
for PKG in "${PKGS[@]}"; do
	echo "Installing $PKG"
	sudo pacman -S "$PKG" --noconfirm
done

echo "--Installing Paru--"
# Install paru Arch User Rrpository helper
cd ~
sudo pacman -S --needed base-devel --noconfirm
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~

echo "--Installing Librewolf--"
# Install librewolf browser
sudo paru -S librewolf-bin

echo "--Installing Brave--"
sudo paru -S brave-bin

# Change swappiness to better value
sysctl vm.swappiness=10

echo "--Getting Dotfiles--"
cd /home/person
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
bash create_symlinks.sh
