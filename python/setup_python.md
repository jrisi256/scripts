# Setting up your Python environment on Linux systems

It can seem intimidating at first when it comes to setting up your Python environment on a Linux system. Should I use the system version of Python that already comes installed? What's `virtualenv` and how is it different from `venv` and how are **they** different from `pyenv`? Should I use my operating system package manager (e.g. `apt` and `yum`) or `pip` to handle all my Python packages? All these things and more I shall go over in this article.

Note the specific commands I'll be going over are for Ubuntu 18.04, but the principles apply broadly to all Linux systems. It should also be stated these are all my opinions as to what are the best practices for managing and installing Python. There is no, single right answer (sadly). Ultimately, you must figure out for yourself what set of tools and practices work best for you. This guide will hopefully get you there faster and more efficiently and with less breaking things.

## System Python

You'll notice on your Linux operating system that you already have Python installed. This is because Linux systems use Python to run system critical tasks. For this reason, I am going to **very strongly** recommend against using the system version of Python. By accidentally updating a specific package/module you could break some dependencies and wind up messing up your entire operating system.

For similar reasons, I am going to caution against downloading Python binaries using your OS package repository (e.g. `yum`, `apt`). While it, of course, segregates any new version of Python downloaded this way from the system-level version of Python, I have found the two installations are still *close*. What do I mean by that? They have similarly named directories and paths basically, and it can very quickly become difficult to keep track of. My head starts spinning just thinking about `/usr/lib/python3.x/dist-pacakges` vs. `/usr/local/lib/python3.y/site-packages`.

## Source install and Anaconda

So how should one go about installing Python? I would recommend either doing a **source install** or install using **Miniconda**. I like to think of Miniconda as its own precompiled binary version of Python that we have more control over how to install (versus installing using the binaries from our OS package repository). I prefer Miniconda to Anaconda because Anaconda is bloated in a lot of ways, and it contains a lot of packages and dependencies you might not want to deal with. For most people who want to go about life without having to worry about their environment too much, Anaconda might be a better option. I prefer the minimalist route however so I only install what I need when I need it.

If one absolutely cannot bear the thought of having any more software than absolutely necessary, or you have your own method for managing source installs then feel free to source install whichever version of Python you choose (as well as `pip`).

### Source install

The steps outlined below are for Ubuntu 18.04, but it wouldn't be so hard to change them to fit your Linux OS. Additionally, the following instructions are taken *ironically* from [documentation from RStudio](https://docs.rstudio.com/connect/admin/python.html#python-install).

First install the dependencies.

```bash
sudo apt install libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev
```

Second download and unpack the source tarball. All Python releases can be found [here](https://www.python.org/ftp/python/) and [here](https://www.python.org/downloads/). For demonstration purposes, we will be installing Python 3.7.1, but these steps apply regardless of the Python version.

```bash
export VERSION=3.7.1 PYTHON_MAJOR=3
wget https://www.python.org/ftp/python/${VERSION}/Python-${VERSION}.tgz
tar -xzvf Python-${VERSION}.tgz
cd Python-${VERSION}
```

Third, you configure, make, and then install. If you want to install into a different location, change the `--prefix` argument. For example, you could do `--prefix=$HOME`. If you are curious about the full range of options available to configure, you can run `./configure --help`.

```bash
./configure --prefix=/opt/Python/${VERSION}
make
sudo make install
```

The final step is to install `pip` and `virtualenv`.

```bash
# Install pip
wget https://bootstrap.pypa.io/get-pip.py
sudo /opt/Python/${VERSION}/bin/python${PYTHON_MAJOR} get-pip.py

# Install virtualenv
sudo /opt/Python/${VERSION}/bin/pip install virtualenv
```

#### Quick aside about sudo pip

You may see on the internet people arguing back and forth about if it's OK or not to use `sudo pip`. Generally what happens is somebody will be unknowingly mixing up their roles as a user vs. a system administrator. As a result, if you use `sudo pip` once you will probably be cursed to continue using it forever. You also run the risk of at some point updating some package or some dependency of a package that your OS depends on which then runs the risk of corrupting your OS. There is also the security risk which comes with using `sudo` and installing any piece of open source software from the internet.

That being said, I am using `sudo` above because we are installing Python packages into an area that needs `sudo` rights, and because the area is segregated from our system-version of Python, we don't run the risk of polluting our library. If you are still concerned about running `sudo pip` you can always install Python somewhere you don't need `sudo` permissions like `$HOME`.

#### Aside over

Well there is one more final optional step which is to add Python (and all associated commands) to your `PATH`. The usual way of doing this would be by adding the following line to a script called say `python.sh` (it can be called anything you want really): `PATH=/opt/python/3.7.1/bin:$PATH`. Then place this script in `/etc/profile.d` which gets read when creating your `PATH`. Just be careful not to have this conflict with other versions of Python you might have installed. You will then have to restart your computer to see the changes reflected in your `PATH`. I can see why this is appealing for people to be able to easily call `python` or `python3` from the command line. However, I find I get confused after a while unless I'm calling directly from the Python directory so I know explicitly what version of Python or `pip` I'm using.

### Miniconda and Anaconda

The steps outlined below are for Ubuntu 18.04, but it wouldn't be so hard to change them to fit your Linux OS. Additionally, the following instructions are taken *ironically again* from [documentation from RStudio](https://docs.rstudio.com/resources/install-python/).

First install the dependencies.

```bash
sudo apt install bzip2 curl
```

Second download the version of Miniconda which corresponds to the version of Python you want which can be [found here](https://github.com/koverholt/anaconda-version-map). In our example, we will be downloading Python 3.8.1 which corresponds to Miniconda3-py38_4.8.2. The repository of all Anaconda versions can be [found here](https://repo.anaconda.com/archive/), and the repository of all Miniconda versions can be [found here](https://repo.anaconda.com/miniconda/). During installation, you may be asked something along the lines of "“Do you wish the installer to initialize Anaconda3 by running `conda init`?” which I believe means it is asking if you want to add the `conda` commands to your `PATH` which I think should be yes. After installing I run, `conda config --set auto_activate_base false` because I don't want `conda init` to be creating base environments by default when opening up the terminal.

```bash
curl -O https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.2-Linux-x86_64.sh
sudo bash Miniconda3-py38_4.8.2-Linux-x86_64.sh
conda config --set auto_activate_base false
rm Miniconda3-py38_4.8.2-Linux-x86_64.sh
```

#### How to install Python packages

At this point you may have seen people installing Python packages using `pip`, using `conda`, using `easy_intall`, using the OS package manager (e.g. `apt` or `yum`), or some other way entirely. I"m here to tell you that unless you have a good reason otherwise that you should use `pip`. Nowadays `pip` uses **wheels** which are precompiled binaries (before it was installing things from source). `pip` packages comes from PyPI, and this covers practically every Python package imaginable. `pip` also doesn't bundle system-level dependencies into the Python package the way `conda` does. Using `conda` can make the install easier in the short run because of this, but it can lead to issues down the road if you install multiple pieces of the same software unknowingly in different ways (e.g. once using `conda` as a dependency in a precompiled binary and then another time using `apt`). This is, of course, an opinionated piece about how to install Python and manage all your packages and what not. Nothing here is technically correct, but in my experience these have been the best practices I have come across. Some people are perfectly fine using `conda`, and that's great! I would caution againsy using `easy_install` or your OS package manager though.

#### End of aside

The final, optional step like [mentioned above for installing from source](#aside-over) would be to add our new executable files to the `PATH`. The steps are the same as the ones from when installing from source.

# TO DO write about Jupyter and write about virtualenv, venv, pyenv, etc. etc. etc.