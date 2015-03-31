#!/bin/sh
#
# Helper script to setup dotfiles automatically from a box with nothing but curl
#
sudo apt-get install git
mkdir -p src/
git clone https://github.com/vekkt0r/dotfiles.git src/dotfiles
cd src/dotfiles
git submodule init
git submodule update
./bootstrap.sh
