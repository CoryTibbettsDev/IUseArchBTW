#!/bin/bash

echo -- Starting chroot.sh -- 

echo -- Symlink Time --
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

echo -- Hardware Clock --
hwclock --systohc

echo -- Generating Locale --
locale-gen

LANG=en_US.UTF-8 >> /etc/locale.conf

echo -- Input Hostname --
echo "arch" >>  /etc/hostname

echo -- Installing Grub --
pacman -S grub --noconfirm --needed
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo -- Installing NetworkManager --
pacman -S networkmanager wpa_supplicant --noconfirm --needed
systemctl enable --now NetworkManager && echo "!! NetworkManager Working !!" || echo "!! NetworkManager not working !!"

echo "ctrl_interface=/run/wpa_supplicant" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf

pacman -S xorg mesa lightdm lightdm-gtk-greeter xlightdm-gtk-greeter-settings monad xmonad-contrib xterm termite epiphany
systemctl enable lightdm.service && echo "!! lightdm working !!" || echo "!! lightdm not working !!"


passwd
