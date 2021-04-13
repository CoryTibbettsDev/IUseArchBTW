#!/bin/sh

# Script for installing all the packages on my system

# Would like to detect the hardware and install based on that

PACKAGES=(
	# Documentation
	man-pages
	# Text Editor
	neovim
	# Xserver windowing
	xorg
	xorg-xinit
	## Run nested xorg server for developement
	# xorg-server-xephyr
	# Window Manager
	awesome
	# Version Control
	git
	cvs
	# Utilities
	tree
	htop
	# For naviagting source code with vim
	# jump to definition with Ctrl-] jump back with Ctrl-o
	ctags
	# Terminal emulator
	kitty
	# Run prompt
	rofi
	# Audio control
	alsa
	alsa-utils
	# Web browser
	epiphany
	# Download videos
	youtube-dl
	# Video player
	mpv
	# Image viewer
	feh # Also use for setting wallpaper
	# CLI file browser
	ranger
	# GUI file browser
	pcmanfm
	# Document viewer
	zathura # https://wiki.archlinux.org/index.php/Zathura
	zathura-pdf-mupfd # PDF EPUB XPS support
	# Auto mount external devices
	udiskie

	#### VirtualBox ####
	# virtualbox
	## For normal arch kernel
	# virtualbox-host-modules-arch
	## For other kernels
	# virtualbox-host-dkms

	#### Games ####
	# wesnoth

	#### DRIVERS ####
	# https://github.com/lutris/docs/blob/master/InstallingDrivers.md
	# If you want to run 32 bit applications install the 32 bit packages
	# edit /etc/pacman.conf and uncomment the mutlilib mirror list
	# Also need these for wine

	# vulkan-validation-layers
	## AMD
	# vulkan-radeon
	# vulkan-icd-loader
	## 32 bit AMD
	# lib32-mesa
	# lib32-vulkan-radeon
	# lib32-vulkan-icd-loader

	## Nvidia
	# nvidia-dkms
	# nvidia-utils
	# nvidia-settings
	# vulkan-icd-loader
	## 32 bit Nvidia
	# lib32-nvidia-utils
	# lib32-vulkan-icd-loader

	## Intel
	# vulkan-intel
	# vulkan-icd-loader
	## 32 bit Intel
	# lib32-mesa
	# lib32-vulkan-intel
	# lib32-vulkan-icd-loader
)
echo "Installing Packages"
for PKG in "${PACKAGES[@]}"; do
	echo "Installing $PKG"
	sudo pacman -S "$PKG" --noconfirm
done

echo "Installing Paru"
# Install paru Arch User Rrpository helper
cd ~
# Dependencies
sudo pacman -S base-devel --noconfirm
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd ~

echo "Installing Librewolf"
# Install librewolf browser
paru -S librewolf-bin --noconfirm

# Command line tool for searching and watching YouTube Videos
# Dependencies are youtube-dl, mpv, jq, (optional for a menu) fzf,
# (optional for thumbnails) ueberzug
# Source code: https://github.com/pystardust/ytfzf
echo "Installing ytfzf"
# Dependencies
sudo pacman -S mpv youtube-dl jq fzf # ueberzug --noconfirm
paru -S ytfzf-git --noconfirm

# Change swappiness to better value
sudo sysctl vm.swappiness=10
echo "vm.swappiness=10" | sudo tee -a /etc/sysctl.d/99-swappiness.conf

echo "Getting Dotfiles"
cd ~
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
sh create_symlinks.sh

# Setup home directory
cd ~
mkdir -v Downloads Media Projects Source
