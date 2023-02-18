#!/bin/bash

################################################################################ System-level dependencies for R and Python.
# Install system dependencies for Python and R.
sudo apt install curl

########################################### Python
# Install system dependencies for Python.
sudo apt install bzip2 default-jre

# Install dependencies for handling PDFs.
sudo apt install libpoppler-cpp-dev

########################################## R
# Install system dependencies for R and RStudio.
sudo apt install gdebi-core

# Install necessary for regressions.
sudo apt install libv8-dev

# Download and install for geospatial R packages.
sudo apt install libgdal-dev libudunits2-dev

# Install necessary packages for curl and openssl packages in R.
sudo apt install libcurl4-openssl-dev libssl-dev

# Install necessary packages for xml2, systemfonts, and gdtools packages in R which are used in flextable.
sudo apt install libxml2-dev libfontconfig1-dev libcairo2-dev

# Install for the magick package.
sudo apt install libmagick++-dev

# Install packages to make use of more sophisticated functionality in igraph as well as some more sophisticated network modeling packages.
sudo apt install libglpk-dev cmake libgsl-dev

# Install LaTeX on for Ubuntu which is necessary to knit RMarkdown files to PDF.
sudo apt install texlive-base texlive-science texlive texlive-latex-recommended texlive-latex-extra texlive-xetex

# Install necessary packages for devtools.
sudo apt install libharfbuzz-dev libfribidi-dev

############################################################################### Programs
# Various programs and system utilities. 
sudo apt install gimp
sudo apt install vlc
sudo apt install gnome-sushi
sudo apt install htop
sudo apt install ncdu
sudo apt install vim
sudo apt install cpu-x
sudo apt install synaptic
sudo apt install drawing
sudo apt install gnome-tweaks
sudo apt install vim
sudo apt install checkinstall

# Notify me when a program running in the terminal completes.
sudo apt install undistract-me
echo 'source /etc/profile.d/undistract-me.sh' >> ~/.bashrc

# Make it so when I click on an icon, the window minimizes.
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

# Download broot which makes CLI folder navigation much nicer.
wget https://dystroy.org/broot/download/x86_64-linux/broot
chmod +x broot
mv broot /usr/local/bin

# Get rid of annoying Ubuntu advertising.
sudo pro config set apt_news=false
sudo rm /etc/apt/apt.conf.d/20apt-esm-hook.conf

# Download Zoom
wget https://zoom.us/client/5.13.7.683/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb
sudo rm zoom_amd64.deb

# Download copyq which keeps track of clipboard.
sudo add-apt-repository ppa:hluk/copyq
sudo apt update
sudo apt install copyq

# Download fsearch which is a super fast utility for searching through all my files.
sudo add-apt-repository ppa:christian-boxdoerfer/fsearch-stable
sudo apt update
sudo apt install fsearch

# Zotero
wget -O zotero.tar "https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=5.0.96.3"
tar -xvf zotero.tar
rm zotero.tar
sudo mv Zotero_linux-x86_64 /opt
/opt/Zotero_linux-x86_64/set_launcher_icon
ln -s /opt/Zotero_linux-x86_64/zotero.desktop ~/.local/share/applications/zotero.desktop

# I downloaded Spotify and OnlyOffice from the Ubuntu App Store.
# For VS Code, I downloaded the .deb file from their website. Then, I installed used gdebi.

# Need to download the deb version of Firefox.
sudo snap remove firefox
sudo add-apt-repository ppa:mozillateam/ppa

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001
' | sudo tee /etc/apt/preferences.d/mozilla-firefox

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

sudo apt install firefox

