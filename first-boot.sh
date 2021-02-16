#!/bin/bash

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
	# PDF viewer
	xpdf
	# zathura
	# groff
	# Auto mount external devices
	udiskie
	# GUI file browser
	pcmanfm
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

echo "--Getting Dotfiles--"
cd /home/person
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
bash create_symlinks.sh
