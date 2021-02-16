#!/bin/bash

echo "Enter Username"
read USERNAME
echo "Enter Hostname (Name of the Computer)"
read HOSTNAME

lsblk
echo "Enter disk (Like: /dev/sda)"
read DISK

timedatectl set-ntp true

parted --script "${DISK}" \
mklabel gpt \
mkpart primary 512MiB -8GiB \
mkpart ESP fat32 1MiB 512MiB \
set 3 esp on

echo "-- Making Filesysten and Swap--"
mkfs.ext4 -L arch "${DISK}1"
mkfs.fat -F32 -n boot "${DISK}2" # (for UEFI systems only)
mount "${DISK}1" /mnt
mkdir -p /mnt/boot # (for UEFI systems only)
mount "${DISK}2" /mnt/boot # (for UEFI systems only)

echo "-- Installing Kernel and Base Software --"
pacstrap /mnt linux linux-firmware base base-devel grub efibootmgr sudo vim networkmanager --noconfirm

echo "-- Generating fstab --"
genfstab -U /mnt >> /mnt/etc/fstab

echo "--Chroot--"
# Commands executed inside /mnt
cat << EOF | arch-chroot /mnt

echo "--Symlink Time--"
ln -sf /usr/share/zoneinfo/America/New_York /etc/localtime

echo "--Hardware Clock--"
hwclock --systohc

echo "--Generating Locale--"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen  
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

echo "--Setting Hostname--"
echo "${HOSTNAME}" >> /etc/hostname

echo "--Installing Grub--"
grub-install --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

echo "-- Enabling Wheel Group --"
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers

echo "--NetworkManager--"
systemctl enable --now NetworkManager && echo "--NetworkManager Working--" || echo "--NetworkManager not working--"

echo "--Creating User--"
useradd -mg wheel "${USERNAME}"

passwd

EOF

echo "All Done Hopefully It Works"