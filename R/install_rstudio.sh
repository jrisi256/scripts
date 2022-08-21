#!/bin/bash

# For Ubuntu 18.04

# Install Rstudio, I install the .deb because it's easier than downloading the tarball (which would require configure/make)
sudo apt install gdebi-core
wget https://download1.rstudio.org/desktop/jammy/amd64/rstudio-2022.07.1-554-amd64.deb
sudo gdebi rstudio-2022.07.1-554-amd64.deb
rm rstudio-2022.07.1-554-amd64.deb