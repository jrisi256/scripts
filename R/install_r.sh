#!/bin/bash

# Download and install necessary OS packages
sudo apt install curl gdebi-core

# Download and install the prepackaged binaries
curl -O https://cdn.rstudio.com/r/ubuntu-1804/pkgs/r-$1_1_amd64.deb
sudo gdebi r-$1_1_amd64.deb
rm r-$1_1_amd64.deb

# Create sym links to the executables to ensure R is available on the default system PATH variable
sudo ln -s /opt/R/$1/bin/R /usr/local/bin/R
sudo ln -s /opt/R/$1/bin/Rscript /usr/local/bin/Rscript