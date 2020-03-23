#!/bin/bash

# Add GPG key to authenticate
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# Add R repository which will be checked automatically for R updates
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'

# Install R with openBLAS
sudo apt install libopenblas-base r-base

# Install Rstudio, I install the .deb because it's easier than downloading the tarball (which would require configure/make)
sudo apt install gdebi-core
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb
sudo gdebi rstudio-1.2.5033-amd64.deb
rm rstudio-1.2.5033-amd64.deb