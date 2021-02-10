#!/bin/bash

timedatectl set-ntp true

echo "-- Partitioning Drive --"
parted --script /dev/sda -- mklabel msdos
parted --script /dev/sda -- mkpart primary 1MiB -8GiB
parted --script /dev/sda -- mkpart primary linux-swap -8GiB 100%

echo "-- Making Filesysten --"
mkfs.ext4 -L arch /dev/sda1
mkswap -L swap /dev/sda2
swapon /dev/sda2

echo "-- Mounting Filesystem --"
mount /dev/sda1 /mnt

echo "-- Installing Kernel and Base Software --"
pacstrap /mnt linux linux-firmware base base-devel vim sudo --noconfirm --needed

echo "-- Generating fstab --"
genfstab -U /mnt >> /mnt/etc/fstab

echo "-- chroot --"
# Commands executed inside /mnt
cat << EOF | arch-chroot /mnt

echo "-- Symlink Time --"
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

echo "-- Hardware Clock --"
hwclock --systohc

echo "-- Generating Locale --"
locale-gen

echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "-- Enabling Wheel Group --"
echo "%wheel	ALL=(ALL:ALL)	SETENV: ALL" >> /etc/sudoers

useradd -mU person

echo "-- Input Hostname --"
echo "arch" >>  /etc/hostname

echo "-- Installing Grub --"
pacman -S grub --noconfirm --needed
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

echo "-- Installing NetworkManager --"
pacman -S networkmanager wpa_supplicant --noconfirm --needed
systemctl enable --now NetworkManager && echo "!! NetworkManager Working !!" || echo "!! NetworkManager not working !!"

echo "ctrl_interface=/run/wpa_supplicant" >> /etc/wpa_supplicant/wpa_supplicant.conf
echo "update_config=1" >> /etc/wpa_supplicant/wpa_supplicant.conf

pacman -S xorg xorg-init mesa xmonad xmonad-contrib git xterm termite epiphany --noconfirm --needed

echo "--Getting Config Files--"
cd /home/person
git clone https://github.com/CoryTibbettsDev/.dotfiles
cd .dotfiles
bash create_symlinks.sh

echo "--Root Password--"
passwd
echo "--User Password--"
passwd person

EOF

echo "-- All Finished Hopefully It Worked --"
