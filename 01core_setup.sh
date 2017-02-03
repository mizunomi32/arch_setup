#!/bin/sh

# configs

ROOTPATH="/mnt"
ESPPATH="/boot/efi"
GRUBTARGET="x86_64-efi"
NEW_HOSTNAME="Mz"
ROOTPASSWD="password"
USERNAME="mizunomi"
USERPASWD="password"

for i in $@ ; do
  case ${i%=*} in
    "ROOTPATH" )
      ROOTPATH=${i#*=}
      ;;
    "ESPPATH" )
      ESPPATH=${i#*=}
      ;;
    "GRUBTARGET" )
      GRUBTARGET=${i#*=}
      ;;
    "NEW_HOSTNAME" )
      NEW_HOSTNAME=${i#*=}
      ;;
    "ROOTPASSWD" )
      ROOTPASSWD=${i#*=}
      ;;
    "USERNAME" )
      USERNAME=${i#*=}
      ;;
    "USERNAME" )
     USERPASWD=${i#*=}
     ;;
  esac
done

set -ux

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
pacstrap ${ROOTPATH} \
  base base-devel vim openssh grub efibootmgr os-prober sudo
#-------------
# genfstab
#-------------
genfstab -U -p /${ROOTPATH} >> /${ROOTPATH}/etc/fstab

# --------
# chroot
# --------
CHROOT="arch-chroot /${ROOTPATH}"

# timezone
$CHROOT ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
$CHROOT hwclock --systohc --utc

# locale
$CHROOT sed -i -e 's/#ja_JP.UTF-8/ja_JP.UTF-8/' /etc/locale.gen
$CHROOT sed -i -e 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
echo LANG=ja_JP.UTF-8 > /${ROOTPATH}/etc/locale.conf
$CHROOT locale-gen
#echo KEYMAP=jp106 > /mnt/etc/vconsole.conf

# yaourt
grep "archlinuxfr" /${ROOTPATH}/etc/pacman.conf
if [ $? -eq 1 ];then
    cat >> /${ROOTPATH}/etc/pacman.conf <<EOF
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
$CHROOT echo "$NEW_HOSTNAME" > /${ROOTPATH}/etc/hostname

# GRUB
$CHROOT mkinitcpio -p linux
$CHROOT grub-install --target=${GRUBTARGET} --efi-directory=${ESPPATH} --bootloader-id=arch_grub --recheck
# if ia32-efi pc
#$CHROOT grub-install --target=i386-efi --efi-directory=/boot/efi --bootloader-id=arch_grub --recheck
$CHROOT sed -i -e 's/^GRUB_TIMEOUT=5$/GRUB_TIMEOUT=1/' /etc/default/grub
$CHROOT grub-mkconfig -o /boot/grub/grub.cfg

# root passed
$CHROOT passwd

# user
$CHROOT useradd -m -g wheel $USERNAME
$CHROOT passwd $USERNAME

set +x
echo "-----------------------"
echo "core install finished."
echo "-----------------------"
