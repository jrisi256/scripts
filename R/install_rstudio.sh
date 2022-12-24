#!/bin/bash

# For Ubuntu 18.04

# Install Rstudio, I install the .deb because it's easier than downloading the tarball (which would require configure/make)
sudo apt install gdebi-core
wget https://download1.rstudio.org/electron/bionic/amd64/rstudio-2022.12.0-353-amd64.deb
sudo gdebi rstudio-2022.12.0-353-amd64.deb
rm rstudio-2022.12.0-353-amd64.deb