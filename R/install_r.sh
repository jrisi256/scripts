#!/bin/bash

# Add GPG key to authenticate
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

# Add R repository which will be checked automatically for R updates
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'

# Install R with openBLAS
sudo apt install libopenblas-base r-base