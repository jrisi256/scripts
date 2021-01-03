#!/bin/bash

# For Ubuntu 20.04

# Download and install necessary OS packages
sudo apt install curl gdebi-core

# Download and install for geospatial R packages
sudo apt install libgdal-dev

# Necessary for curl, openssl package in R
sudo apt install libcurl4-openssl-dev libssl-dev

# Necessary for xml2, systemfonts, and gdtools packages in R which are used in flextable
sudo apt install libxml2-dev libfontconfig1-dev libcairo2-dev

# Install LaTeX on for Ubuntu which is necessary for to knit RMarkdown files to PDF
sudo apt install texlive-base texlive-science texlive texlive-latex-recommended texlive-latex-extra

# Download and install the prepackaged binaries
curl -O https://cdn.rstudio.com/r/ubuntu-1804/pkgs/r-$1_1_amd64.deb
sudo gdebi r-$1_1_amd64.deb
rm r-$1_1_amd64.deb

# Create sym links to the executables to ensure R is available on the default system PATH variable
sudo ln -sf /opt/R/$1/bin/R /usr/local/bin/R
sudo ln -sf /opt/R/$1/bin/Rscript /usr/local/bin/Rscript
