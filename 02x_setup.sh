#!/bin/sh
set -ux

USERNAME="mizunomi"
CHROOT="arch-chroot /mnt"
PACMAN="$CHROOT pacman -S --noconfirm"
YAOURT="$CHROOT sudo -u mizunomi yaourt -S --noconfirm"

# x11
$PACMAN xorg-server xorg-server-utils xorg-xinit xorg-xclock xterm
$PACMAN xf86-video-intel
$PACMAN xf86-input-synaptics

# i3-wm
$PACMAN i3
$YAOURT dmenu2

$PACMAN lightdm lightdm-gtk-greeter
$CHROOT systemctl enable lightdm.service

# font
$YAOURT ttf-ricty otf-ipafont ttf-vlgothic

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
$YAOURT emacs atom firefox gimp vlc zsh pcmanfm gvfs ntfs-3g gvfs-mtp gvfs-gphoto2 gvfs-afc gvfs-smb sshfs tumbler ffmpegthumbnailer unzip libreoffice-still rxvt-unicode
set +x
echo "-----------------------"
echo "X install finished."
echo "-----------------------"
