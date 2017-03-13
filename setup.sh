#!/bin/sh

ROOTPATH="/mnt"

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

echo "==================================================="
echo -e "root path\t: $ROOTPATH"
echo "You can not install now"
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
#wget https://github.com/mizunomi32/arch_setup/archive/master.zip

set +x
echo "-----------------------"
echo "ALL install finished."
echo "-----------------------"
