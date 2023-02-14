#!/bin/bash

# Argument 1 is the OS, for example ubuntu-2204.
# Argument 2 is the version of Python, for example 3.11.0

# Download and install Python
curl -O https://cdn.rstudio.com/python/$1/pkgs/python-$2_1_amd64.deb
sudo gdebi python-$2_1_amd64.deb
rm python-$2_1_amd64.deb

# Add Python (and related commands) to our PATH
touch python.sh
echo PATH=/opt/python/$2/bin:'$PATH' >> python.sh
sudo mv python.sh /etc/profile.d/

# This doesn't propagate up to our current shell environment so you'll have to run it manually (or restart for it to be permanent)
source /etc/profile.d/python.sh

# Install Jupyter and virtualenv, make sure pip is pointing to the version of pip just installed
pip install jupyter jupyterlab virtualenv

# Download and install gecko webdriver - https://github.com/mozilla/geckodriver/releases
# Just download it somewhere, unload the tarball, then add it to the system path
# I just moved the file to /usr/local/bin
