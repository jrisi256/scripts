# Setting up your Python environment on Linux systems

It can seem intimidating at first when it comes to setting up your Python environment on a Linux system. Should I use the system version of Python that already comes installed? What's `virtualenv` and how is it different from `venv` and how are **they** different from `pyenv`? Should I use my operating system package manager (e.g. `apt` and `yum`) or `pip` to handle all my Python packages? All these things and more I shall go over in this article.

Note the specific commands I'll be going over are for Ubuntu 18.04, but the principles apply broadly to all Linux systems.

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

Well there is one more final optional step which is to add Python (and all associated commands) to your `PATH`. The usual way of doing this would be by adding the following line to a script called say `python.sh` (it can be called anything you want really): `PATH=/opt/python/3.7.1/bin:$PATH`. Then place this script in `/etc/profile.d` which gets read when creating your `PATH`. Just be **very** careful not to have this conflict with whatever the system has already set up on the `PATH` concerning Python or other versions of Python you might have installed. Check `/usr/bin` to see what python is called there. On Ubuntu 18.04, it is `python3.6` and `python3`. You will then have to restart your computer to see the changes reflected in your `PATH`.

### Miniconda and Anaconda