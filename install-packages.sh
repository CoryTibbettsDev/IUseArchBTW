#!/bin/bash

echo -e "\nINSTALLING SOFTWARE\n"

PKGS=(
	# Long term support kernel
    'linux-lts'

	# -- Window Manager --
	'xmonad'
	'xmonad-contrib'
	# Compositor
	'picom'
	# Wallpaper manager
	'nitrogen'
	# -- Terminal Emulators --
	'xterm'
	'termite'
	# Editors
	'vim'

	# -- System Utilites --
	# Version management
	'git'
	# Display system info
	'neofetch'
	# Get remote content
	'wget'
	'curl'
	# Show system processes and resources
	'htop'
	# View file structure in terminal
	'tree'
	# Auto mount external drives
	'udiskie'

	# -- Compilers and Language Utilities --
	'gnumake'
	# C compiler
	'gcc'
	# Haskell compiler
	'ghc'
	# Scripting language 
	'python'

	# -- File Manager --
	'pcmanfm'

	# -- Media --
	# Video player
	'mplayer'
	# Image viewer
	'geeqie'
	# PDF viewer
	'xpdf'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done

echo -e "\nDone!\n"
