#!/bin/bash

# Argument 1 is the OS, for example ubuntu-2204.
# Argument 2 is the verison of R, for example 4.2.2

# Download and install the prepackaged binaries
curl -O https://cdn.rstudio.com/r/$1/pkgs/r-$2_1_amd64.deb
sudo gdebi r-$2_1_amd64.deb
rm r-$2_1_amd64.deb

# Create sym links to the executables to ensure R is available on the default system PATH variable
sudo ln -sf /opt/R/$2/bin/R /usr/local/bin/R
sudo ln -sf /opt/R/$2/bin/Rscript /usr/local/bin/Rscript

# Install R Packages which are used across all R projects.
# renv ignores the user's directory so I will comment this out.
# Useful to have around because I always install these packages for every project I work on.
# R -e 'install.packages(c("devtools", "renv", "markdown", "rmarkdown", "lintr"), repos = "http://cran.us.r-project.org")'