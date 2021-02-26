#!/bin/bash

# Script for installing desktop version of my system

PACKAGES=(
	# Xserver windowing
	xorg
	xorg-xinit
	# Window Manager
	awesome
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

    ########## MEDIA STUFF #############
	# Download YouTube videos and stream with mpv
	youtube-dl
	# Video player
	mpv
	# Image viewer
	geeqie
	# GUI file browser
	pcmanfm
	# PDF viewer
	xpdf
	# Auto mount external devices
	udiskie
    ####################################

    ######### DRIVERS ##################
    # Drivers for GPUs generally don't need for basic boot just games/intense graphics programs
    # Info from link below
    # https://github.com/lutris/docs/blob/master/InstallingDrivers.md

    # If you want to run 32 bit applications install the 32 bit packages 
    # edit /etc/pacman.conf and uncomment the mutlilib mirror list

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
    # 32 bit Intel
    ## lib32-mesa
    # lib32-vulkan-intel
    # lib32-vulkan-icd-loader
    ################################
)
echo "--Installing Packages--"
for PKG in "${PACKAGES[@]}"; do
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
paru -S librewolf-bin --noconfirm

# Command line tool for searching YouTube Videos
echo "--Installing ytfzf--"
paru -S ytfzf-git --noconfirm

# Change swappiness to better value
sudo sysctl vm.swappiness=10

echo "--Getting Dotfiles--"
cd /home/person
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
bash create_symlinks.sh
