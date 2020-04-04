#!/bin/bash

# For Ubuntu 18.04

# Install dependencies
sudo apt install bzip2 curl

# Download and install Miniconda
curl -O https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.2-Linux-x86_64.sh
bash Miniconda3-py38_4.8.2-Linux-x86_64.sh -p $1
rm Miniconda3-py38_4.8.2-Linux-x86_64.sh

# Add Python (and related commands) to our PATH
touch python.sh
echo PATH=$1/bin:'$PATH' >> python.sh
sudo mv python.sh /etc/profile.d/
# source /etc/profile.d/python.sh # This doesn't propagate up to our current shell environment

# Turn off conda automatically activating its environment
# conda config --set auto_activate_base false

# Install Jupyter and virtualenv, make sure pip is pointing to the version of pip just installed
# pip install jupyter jupyterlab virtualenv