#!/bin/bash

# Argument 1 is the OS, for example jammy.
# Argument 2 is the version of RStudio, for example 2022.12.0-353.

wget https://download1.rstudio.org/electron/$1/amd64/rstudio-$2-amd64.deb
sudo gdebi rstudio-$2-amd64.deb
rm rstudio-$2-amd64.deb
