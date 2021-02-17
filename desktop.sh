#!/bin/bash

# Script for installing desktop version of my system

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
	neofetch
	htop
	# Wallpaper manager
	nitrogen
	# Terminal emulator
	termite
	# Web browser
	epiphany
	# Audio control
	alsa
	alsa-utils
	# Video player
	mpv
	# GUI file browser
	pcmanfm
	# PDF viewer
	xpdf
	# zathura
	# groff
	# Auto mount external devices
	udiskie
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
paru -S librewolf-bin

# Change swappiness to better value
sysctl vm.swappiness=10

echo "--Getting Dotfiles--"
cd /home/person
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
bash create_symlinks.sh
