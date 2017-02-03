#!/bin/sh

echo -n "Do you need X? (y/n)"
read needx

set -ux
mkdir arch_setup
cd arch_setup
wget https://mizunomi32.github.io/arch_setup/01core_setup.sh
./01core_setup.sh
set +x

case needx in
  "y")
    set -ux
    wget https://mizunomi32.github.io/arch_setup/02x_setup.sh
    ./02x_setup.sh
    set +x
    ;;
esac
echo "-----------------------"
echo "ALL install finished."
echo "-----------------------"
