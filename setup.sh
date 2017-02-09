#!/bin/sh

ROOTPATH="/mnt"
ESPPATH="/boot/efi"
GRUBTARGET="x86_64-efi"
NEEDX=true
VGA="Intel"
NEW_HOSTNAME="Mz"
ROOTPASSWD="password"
USERNAME="mizunomi"
USERPASWD="password"

# ROOTPATH
echo -n "new root path (default \"/mnt\") : "
read intxt
case $intxt in
  "" )
  ;;
  * )
  ROOTPATH=$intxt
  intxt=""
  ;;
esac
# ESPPATH
echo -n "new ESP path (default \"/boot/efi\") : "
read intxt
case $intxt in
  "" )
  ;;
  * )
  ESPPATH=$intxt
  intxt=""
  ;;
esac
# GRUBTARGET
echo -n "GRUB target(default \"x86_64-efi\") : "
read intxt
case $intxt in
  "" )
  ;;
  * )
  GRUBTARGET=$intxt
  intxt=""
  ;;
esac
# HOSTNAME
echo -n "Hostname (default Mz) : "
read intxt
case $intxt in
  "" )
  ;;
  * )
  NEW_HOSTNAME=$intxt
  intxt=""
  ;;
esac
# ROOTPASSWD
echo -n "root password (default password) : "
read intxt
case $intxt in
  "" )
  ;;
  * )
  ROOTPASSWD=$intxt
  intxt=""
  ;;
esac
# USERNAME
echo -n "username (default mizunomi) : "
read intxt
case $intxt in
  "" )
  ;;
  * )
  USERNAME=$intxt
  intxt=""
  ;;
esac
# USERPASWD
echo -n "user password (default password) : "
read intxt
case $intxt in
  "" )
  ;;
  * )
  USERPASWD=$intxt
  intxt=""
  ;;
esac

echo "==================================================="
echo -e "root path\t: $ROOTPATH"
echo -e "ESP path\t: $ESPPATH"
echo -e "grub target\t: $GRUBTARGET"
echo -e "X window system\t: $NEEDX"
if $NEEDX ; then
  echo -e "VGA\t\t: $VGA"
fi
echo -e "Hostname\t: $NEW_HOSTNAME"
echo -e "root password\t: $ROOTPASSWD"
echo -e "username\t: $USERNAME"
echo -e "user password\t: $USERPASWD"
echo "==================================================="
while true ; do
  echo -n "Is this OK? (y/n) : "
  read intxt
  case $intxt in
    "y" )
      break
      ;;
    "n" )
      echo "Retry!"
      exit
      ;;
  esac
done

#set -ux
wget https://mizunomi32.github.io/arch_setup/01core_setup.sh
chmod +x 01core_setup.sh
./01core_setup.sh ROOTPATH=${ROOTPATH} ESPPATH=${ESPPATH} GRUBTARGET=${GRUBTARGET} NEW_HOSTNAME=${NEW_HOSTNAME} ROOTPASSWD=${ROOTPASSWD} USERNAME=${USERNAME} USERPASWD=${USERPASWD}

wget https://mizunomi32.github.io/arch_setup/02x_setup.sh
chmod +x 02x_setup.sh
./02x_setup.sh ROOTPATH=${ROOTPATH} USERNAME=${USERNAME} VGA=${VGA}

wget https://mizunomi32.github.io/arch_setup/03i3wm_setup.sh
chmod +x 03i3wm_setup.sh
./03i3wm_setup.sh ROOTPATH=${ROOTPATH} USERNAME=${USERNAME} VGA=${VGA}

set +x
echo "-----------------------"
echo "ALL install finished."
echo "-----------------------"
echo "You need reboot"
