#!/bin/bash

# For Ubuntu 18.04

# Download and install necessary OS packages
sudo apt install curl gdebi-core

# Necessary for curl, openssl package in R
sudo apt install libcurl4-openssl-dev libssl-dev

# Download and install the prepackaged binaries
curl -O https://cdn.rstudio.com/r/ubuntu-1804/pkgs/r-$1_1_amd64.deb
sudo gdebi r-$1_1_amd64.deb
rm r-$1_1_amd64.deb

# Create sym links to the executables to ensure R is available on the default system PATH variable
sudo ln -sf /opt/R/$1/bin/R /usr/local/bin/R
sudo ln -sf /opt/R/$1/bin/Rscript /usr/local/bin/Rscript
