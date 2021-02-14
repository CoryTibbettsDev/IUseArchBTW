#!/bin/bash

PKGS=(
	# Xserver windowing
	xorg
	xorg-xinit
	# Desktop environment
	xmonad
	xmonad-contrib
	xmobar # xmonad status bar
	# Run prompt
	dmenu
	# Utilities
	git
	curl
        # Wallpaper manager
        nitrogen
	# Terminal emulator
	termite
	# Web browser
	epiphany
	# Audio control
	pulseaudio
	# Video player
	mpv
)

echo "--Installing Packages--"
for PKG in "${PKGS[@]}"; do
	echo "Installing $PKG"
	sudo pacman -S "$PKG" --noconfirm
done

echo "--Getting Dotfiles--"
cd /home/person
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
bash create_symlinks.sh
