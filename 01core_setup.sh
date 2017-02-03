#!/bin/sh
set -ux

# configs
NEW_HOSTNAME="Mz"
NEW_USER="mizunomi"

#-------------
# mirror
#-------------
cat > /etc/pacman.d/mirrorlist <<EOF
Server = http://ftp.nara.wide.ad.jp/pub/Linux/archlinux/\$repo/os/\$arch
Server = http://ftp.kddilabs.jp/Linux/packages/archlinux/\$repo/os/\$arch
Server = http://srv2.ftp.ne.jp/Linux/packages/archlinux/\$repo/os/\$arch
Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/\$repo/os/\$arch
Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/\$repo/os/\$arch
Server = http://mirror.archlinuxjp.org/\$repo/os/\$arch
Server = rsync://rsync.kddilabs.jp/Linux/packages/archlinux/\$repo/os/\$arch
Server = rsync://ftp.jaist.ac.jp/pub/Linux/ArchLinux/\$repo/os/\$arch
Server = rsync://ftp.tsukuba.wide.ad.jp/Linux/archlinux/\$repo/os/\$arch

EOF

#-------------
# pacstrap
#-------------
pacstrap /mnt \
  base base-devel vim openssh grub efibootmgr os-prober sudo
#-------------
# genfstab
#-------------
genfstab -U -p /mnt >> /mnt/etc/fstab

# --------
# chroot
# --------
CHROOT="arch-chroot /mnt"

# timezone
$CHROOT ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
$CHROOT hwclock --systohc --utc

# locale
$CHROOT sed -i -e 's/#ja_JP.UTF-8/ja_JP.UTF-8/' /etc/locale.gen
$CHROOT sed -i -e 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
echo LANG=ja_JP.UTF-8 > /mnt/etc/locale.conf
$CHROOT locale-gen
#echo KEYMAP=jp106 > /mnt/etc/vconsole.conf

# yaourt
grep "archlinuxfr" /mnt/etc/pacman.conf
if [ $? -eq 1 ];then
    cat >> /mnt/etc/pacman.conf <<EOF
[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch
EOF
fi
$CHROOT pacman -Sy --noconfirm archlinuxfr/yaourt

# pacman
$CHROOT pacman -Syu --noconfirm
$CHROOT pacman -Sc --noconfirm

# WLAM(wifi-menu)
$CHROOT pacman -S --noconfirm iw wpa_supplicant dialog
# hostname
$CHROOT echo "$NEW_HOSTNAME" > /mnt/etc/hostname

# GRUB
$CHROOT mkinitcpio -p linux
$CHROOT grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
# if ia32-efi pc
#$CHROOT grub-install --target=i386-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
$CHROOT sed -i -e 's/^GRUB_TIMEOUT=5$/GRUB_TIMEOUT=1/' /etc/default/grub
$CHROOT grub-mkconfig -o /boot/grub/grub.cfg

# root passed
$CHROOT passwd

# user
$CHROOT useradd -m -g wheel $NEW_USER
$CHROOT passwd $NEW_USER

set +x
echo "-----------------"
echo "install finished."
echo "-----------------"
