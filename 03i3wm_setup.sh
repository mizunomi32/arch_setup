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
$PACMAN i3
$PACMAN lightdm lightdm-gtk-greeter
$CHROOT systemctl enable lightdm.service

# mozc
$PACMAN  fcitx-im fcitx-configtool fcitx-mozc
cat > /mnt/etc/locale.conf <<EOF
LANG=ja_JP.UTF-8
# LANG=en_US.UTF-8
EOF
cat >> /mnt/home/$USERNAME/.xprofile <<EOF
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”
EOF
cat >> /mnt/home/$USERNAME/.xinitrc <<EOF
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”
EOF

$PACMAN networkmanager dhclient gnome-icon-theme network-manager-applet gnome-keyring alsa-utils volumeicon pavucontrol pulseaudio mplayer
$CHROOT systemctl enable NetworkManager

$YAOURT dmenu2 ttf-ricty otf-ipafont ttf-vlgothic emacs atom firefox gimp vlc zsh pcmanfm gvfs ntfs-3g gvfs-mtp gvfs-gphoto2 gvfs-afc gvfs-smb sshfs tumbler ffmpegthumbnailer unzip libreoffice-still rxvt-unicode dropbox-experimental gitkraken skype slack

set +x
echo "-----------------------"
echo "i3wm install finished."
echo "-----------------------"
