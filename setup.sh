#!/bin/sh

echo -n "Do you need X? (y/n)"
read needx

set -ux
mkdir arch_setup
cd arch_setup
wget https://mizunomi32.github.io/arch_setup/01core_setup.sh
set +x
echo -n "Do you edit 01core_setup.sh X? (y/n)"
read edityn
case $edityn in
  "y" )
    vim 01core_setup.sh
    edityn="n"
    ;;
esac
./01core_setup.sh


case $needx in
  "y")
    set -ux
    wget https://mizunomi32.github.io/arch_setup/02x_setup.sh
    set +x
    echo -n "Do you edit 02x_setup.sh X? (y/n)"
    read edityn
    case $edityn in
      "y" )
        vim 02x_setup.sh
        edityn="n"
        ;;
    esac
    ./02x_setup.sh

    ;;
esac
echo "-----------------------"
echo "ALL install finished."
echo "-----------------------"
