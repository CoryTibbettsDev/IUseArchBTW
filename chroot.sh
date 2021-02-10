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
vim /etc/hostname

echo -- Installing Grub --
pacman -S grub
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo -- Installing NetworkManager --
pacman -S networkmanager wpa_supplicant --noconfirm --needed
systemctl enable --now NetworkManager && echo "!!NetworkManager Working!!" || echo "!!NetworkManager not working!!"

pacman -S xorg mesa lightdm xmonad xmonad-contrib xterm termite epiphany
systemctl enable lightdm

passwd

umount -R /mnt
