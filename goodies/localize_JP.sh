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

# mozc
$PACMAN  fcitx-im fcitx-configtool fcitx-mozc

$PACMAN otf-ipafont ttf-vlgothic

cat > /mnt/etc/locale.conf <<EOF
LANG=ja_JP.UTF-8
# LANG=en_US.UTF-8
EOF

cat >> /mnt/home/$USERNAME/.xprofile <<EOF
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”
EOF

cat >> /mnt/home/$USERNAME/.xinitrc <<EOF
export DefaultImModule=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=”@im=fcitx”
EOF


# ttf-ricty
