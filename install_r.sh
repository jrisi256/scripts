#!/bin/bash

# Add GPG key to authenticate
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# Add R repository which we will be checked automatically for R updates
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'

# Install R with openBLAS
sudo apt install libopenblas-base r-base

# Install Rstudio, I install the .deb because it's easier than downloading the tarball (which would require me configure and compile I think).
sudo apt install gdebi-core
wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5033-amd64.deb
sudo gdebi rstudio-1.2.5033-amd64.deb
rm rstudio-1.2.5033-amd64.deb

# If you are curious about how to install multiple versions of R see the below links:
# https://docs.rstudio.com/resources/install-r/
# https://support.rstudio.com/hc/en-us/articles/360002242413-Multiple-versions-of-R