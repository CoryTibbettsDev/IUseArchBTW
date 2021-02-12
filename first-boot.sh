#!/bin/bash

echo "--Installing Packages--"
sudo pacman -S vim git xorg xorg-xinit xmonad xmonad-contrib termite epiphany --noconfirm 

echo "--Getting Dotfiles--"
cd /home/person
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
bash create_symlinks.sh
