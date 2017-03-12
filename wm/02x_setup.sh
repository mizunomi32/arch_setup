#!/bin/sh
set -ux

VGA="Intel"
USERNAME="mizunomi"
ROOTPATH="/mnt"

for i in $@ ; do
  case ${i%=*} in
    "user" )
      USERNAME=${i#*=}
      ;;
    "vga" )
      VGA=${i#*=}
      ;;
    "rootpath" )
      ROOTPATH=${i#*=}
      ;;
  esac
done

CHROOT="arch-chroot $ROOTPATH"
PACMAN="$CHROOT pacman -S --noconfirm"
YAOURT="$CHROOT sudo -u $USERNAME yaourt -S --noconfirm"

set -ux
# x11
$PACMAN xorg-server xorg-server-utils xorg-xinit xorg-xclock xterm
# case ${VGA,,} in
#   "intel" )
#         ;;
#   * )
#     echo "==============================="
#     echo "You shud install video driver !"
#     echo "==============================="
# esac
$PACMAN xf86-video-vesa xf86-video-ati xf86-video-intel xf86-video-nouveau

$PACMAN xf86-input-synaptics

echo "-----------------------"
echo "X install finished."
echo "-----------------------"
