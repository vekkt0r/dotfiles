#!/bin/sh

sudo su -c 'dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm'
#Enable COPR repository with packages from this repo:
sudo dnf copr enable dawid/better_fonts
#Install packages:
sudo dnf install fontconfig-enhanced-defaults fontconfig-font-replacements

#identify lcd panel type
#http://www.lagom.nl/lcd-test/subpixel.php
#query current dpi: xdpyinfo | grep -B 2 resolution
#set dpi in .Xresources
