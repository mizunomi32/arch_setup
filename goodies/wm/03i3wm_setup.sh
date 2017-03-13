#!/bin/sh

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
# i3-wm
$PACMAN i3 lightdm lightdm-gtk-greeter



$PACMAN networkmanager dhclient gnome-icon-theme network-manager-applet gnome-keyring alsa-utils volumeicon pavucontrol pulseaudio mplayer


$PACMAN emacs atom firefox gimp vlc zsh pcmanfm gvfs gvfs-mtp gvfs-gphoto2 gvfs-afc gvfs-smb sshfs tumbler ffmpegthumbnailer unzip libreoffice-still rxvt-unicode 
$YAOURT dmenu2 dropbox-experimental gitkraken skype slack

$CHROOT systemctl enable NetworkManager lightdm.service

set +x
echo "-----------------------"
echo "i3wm install finished."
echo "-----------------------"
