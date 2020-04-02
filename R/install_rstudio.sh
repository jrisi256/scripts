#!/bin/bash

# For Ubuntu 18.04

# Install Rstudio, I install the .deb because it's easier than downloading the tarball (which would require configure/make)
sudo apt install gdebi-core
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb
sudo gdebi rstudio-1.2.5033-amd64.deb
rm rstudio-1.2.5033-amd64.deb