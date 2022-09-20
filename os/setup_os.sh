#!/bin/bash

# For Ubuntu 18.04

# Have to install vim
sudo apt install vim

# Useful for when I have to install things from source, allows me to keep track of them better
sudo apt install checkinstall

# need to download the deb version of firefox
sudo snap remove firefox
sudo add-apt-repository ppa:mozillateam/ppa

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

sudo apt install firefox