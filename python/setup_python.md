# Setting up your Python environment on Linux systems

It can seem intimidating at first when it comes to setting up your Python environment on a Linux system. Should I use the system version of Python that already comes installed? What's `virtualenv` and how is it different from `venv` and how are **they** different from `pyenv`? Should I use my operating system package manager (e.g. `apt` and `yum`) or `pip` to handle all my Python packages? All these things and more I shall go over in this article.

Note the specific commands I'll be going over are for Ubuntu 18.04, but the principles apply broadly to all Linux systems. It should also be stated these are all my opinions as to what are the best practices for managing and installing Python. There is no, single right answer (sadly). Ultimately, you must figure out for yourself what set of tools and practices work best for you. This guide will hopefully get you there faster and more efficiently and with less things breaking.

## System Python

You'll notice on your Linux operating system that you already have Python installed. This is because Linux systems use Python to run system critical tasks. For this reason, I am going to **very strongly** recommend against using the system version of Python. By accidentally updating a specific package/module you could break some dependencies and wind up messing up your entire operating system.

For similar reasons, I am going to caution against downloading Python binaries using your OS package repository (e.g. `yum`, `apt`). While it, of course, segregates any new version of Python downloaded this way from the system-level version of Python, I have found the two installations are still *close*. What do I mean by that? They have similarly named directories and paths basically, and it can very quickly become difficult to keep track of. My head starts spinning just thinking about `/usr/lib/python3.x/dist-pacakges` vs. `/usr/local/lib/python3.y/site-packages`.

## Source install and Anaconda

So how should one go about installing Python? I would recommend either doing a **source install** or install using **Miniconda**. I like to think of Miniconda as its own precompiled binary version of Python that we have more control over how to install (versus installing using the binaries from our OS package repository). I prefer Miniconda to Anaconda because Anaconda is bloated in a lot of ways, and it contains a lot of packages and dependencies you might not want to deal with. For most people who want to go about life without *ever* having to worry about their environment too much, Anaconda might be a better option. I prefer the minimalist route however so I only install what I need when I need it.

If one absolutely cannot bear the thought of having any more software than absolutely necessary, or you have your own method for managing source installs then feel free to source install whichever version of Python you choose (as well as `pip`).

### Source install

The steps outlined below are for Ubuntu 18.04, but it wouldn't be so hard to change them to fit your Linux OS. Additionally, the following instructions are taken *ironically* from [documentation from RStudio](https://docs.rstudio.com/connect/admin/python.html#python-install).

First install the dependencies.

```bash
sudo apt install libffi-dev libgdbm-dev libsqlite3-dev libssl-dev zlib1g-dev wget
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

The final step is to install `pip`.

```bash
# Install pip
wget https://bootstrap.pypa.io/get-pip.py
sudo /opt/Python/${VERSION}/bin/python${PYTHON_MAJOR} get-pip.py
```

#### Quick aside about sudo pip

You may see on the internet people arguing back and forth about if it's OK or not to use `sudo pip`. Generally what happens is somebody will be unknowingly mixing up their roles as a user vs. a system administrator. As a result, if you use `sudo pip` once you will probably be cursed to continue using it forever. You also run the risk of at some point updating some package or some dependency of a package that your OS depends on which then runs the risk of corrupting your OS. There is also the security risk which comes with using `sudo` and installing any piece of open source software from the internet.

That being said, I am using `sudo` in this tutorial because we are installing Python packages into an area that needs `sudo` rights, and because the area is segregated from our system-version of Python, we don't run the risk of polluting our library. If you are still concerned about running `sudo pip` you can always install Python somewhere you don't need `sudo` permissions like `$HOME`.

#### Aside over

Well there is one more final optional step which is to add Python (and all associated commands) to your `PATH`. The usual way of doing this would be by adding the following line to a script called say `python.sh` (it can be called anything you want really): `PATH=/opt/python/3.7.1/bin:$PATH`. Then place this script in `/etc/profile.d` which gets read when creating your `PATH`. Just be careful not to have this conflict with other versions of Python you might have installed. You would then run `source /etc/profile.d/python.sh` to see the changes reflected in your `PATH` (you'll have to restart your computer for it to be permanent and not just for your current shell session).

### Miniconda and Anaconda

The steps outlined below are for Ubuntu 18.04, but it wouldn't be so hard to change them to fit your Linux OS. Additionally, the following instructions are taken *ironically again* from [documentation from RStudio](https://docs.rstudio.com/resources/install-python/).

First install the dependencies.

```bash
sudo apt install bzip2 curl
```

Second download the version of Miniconda which corresponds to the version of Python you want which can be [found here](https://github.com/koverholt/anaconda-version-map). In our example, we will be downloading Python 3.8.1 which corresponds to `Miniconda3-py38_4.8.2`. The repository of all Anaconda versions can be [found here](https://repo.anaconda.com/archive/), and the repository of all Miniconda versions can be [found here](https://repo.anaconda.com/miniconda/). During installation, you may be asked something along the lines of "“Do you wish the installer to initialize Anaconda3 by running `conda init`?” which I believe means it is asking if you want to add the `conda` commands to your `PATH` which I think should be yes. After installing I run, `conda config --set auto_activate_base false` because I don't want `conda init` to be creating base environments by default when opening up the terminal.

```bash
curl -O https://repo.anaconda.com/miniconda/Miniconda3-py38_4.8.2-Linux-x86_64.sh
sudo bash Miniconda3-py38_4.8.2-Linux-x86_64.sh
conda config --set auto_activate_base false
rm Miniconda3-py38_4.8.2-Linux-x86_64.sh
```

And that's it. See [above](#aside-over) on how to add Python to your `PATH`.

#### How to install Python packages

At this point you may have seen people installing Python packages using `pip`, using `conda`, using `easy_intall`, using the OS package manager (e.g. `apt` or `yum`), or some other way entirely. I"m here to tell you that unless you have a good reason otherwise that you should use `pip`. Nowadays `pip` uses **wheels** which are precompiled binaries (before `pip` was installing things from source). `pip` packages comes from PyPI, and this covers practically every Python package imaginable. `pip` also doesn't bundle system-level dependencies into the Python package the way `conda` does. Using `conda` can make the install easier in the short run because of this, but it can lead to issues down the road if you install multiple pieces of the same software unknowingly in different ways (e.g. once using `conda` as a dependency in a precompiled binary and then another time using `apt`). This is, of course, an opinionated piece about how to install Python and manage all your packages and what not. Nothing here is technically correct, but in my experience these have been the best practices I have come across. Some people are perfectly fine using `conda`, and that's great! I would caution against using `easy_install` or your OS package manager though. Regardless of whatever you choose, stick with it and only use that one package manager to manage your Python packages. It can very quickly become a nightmare to try and manage Python packages installed using different package managers.

## Installing Jupyter

If you installed Anaconda, you can skip this step. However, if you installed Miniconda or Python from source you'll have to do these steps. That is assuming you want Jupyter installed which I think you should. Their products have made it much easier and more enjoyable for me to program in Python.

Perhaps a bit confusingly, you must install Jupyter using `pip` (or `conda` or whatever you've chosen to manage Python packages). If you have multiple versions of Python installed, you have to choose which version will be the one running Jupyter. I generally choose whatever the latest version I have installed at the time. Run the following commands to install Jupyter. We will be installing Jupyter using Python 3.8.1, but, to reiterate, you can choose whichever version you want.

```bash
# If you've added your Python install to your PATH, you can just call pip without specifying its path
/opt/python/3.8.1/bin/pip install jupyter jupyterlab
```

Then to start running a notebook or lab session you can run `/opt/python/3.8.1/bin/jupyter notebook` or `/opt/python/3.8.1/bin/jupyter lab`.

### How to rename your kernel

This is pretty easy. First find out where all your kernels are installed by typing `/opt/python/3.8.1/bin/jupyter kernelspec list`. In our example, the kernel of interest (Python 3.8.1) will be at `/opt/python/3.8.1/share/jupyter/kernels/python3/`. If you navigate there, you will find a file called `kernel.json`. When you open it up, you will see a property called `display_name`. You would then change to the value to whatever you want to call your kernel. I called mine `Python 3.8.1`.

### How to install more than one kernel

Let's say you also want to use the version of Python you installed from source earlier (3.7.1). One option would be to install Jupyter there too. However, it wouldn't exactly be seamless to go back and forth between the two versions. You would have to have two separate versions of Jupyter running every time. It's not a great solution. So what I recommend you do instead is to install Python 3.7.1 as a new *kernel*. It's fairly easy to do.

First install the Python package `ipykernel` in the target version of Python.

```bash
sudo /opt/python/3.7.1/bin/pip install ipykernel
```

Then to finish up, all you have to do is register this new kernel so Jupyter knows about it. The `--name` property is the internal name of the kernel, and `--display-name` is the outward facing name. You can name them whatever you like.

```bash
sudo /opt/python/3.7.1/bin/python -m ipykernel install --name py3.7.1 --display-name "Python 3.7.1"
```

## `venv`, `virtualenv`, `pyenv`, and `Poetry`. Oh my!

In every good tutorial I've come across that talks about setting up Python, they always mention a **virtual environment** tool you should be using. So before getting into the specifics, let's motivate virtual environments and explain what they are specifically.

So what are virtual environments, and why are they important? Virtual environments are simply isolated development environments which users should use to isolate different projects they have. Specifically we are creating isolated package libraries. The classic scenario is imagine you have **Project A** which needs version 1.1.2 of the Python package `pandas`. Imagine then **Project B** needs version 1.0.9 of `pandas`. The peculiarities of Python don't easily allow for multiple versions of packages to exist and so you would have a problem on your hand. The solution is to use virtual environments to isolate your projects and their respective package libraries. This way each project can have whatever packages and whatever versions of those packages that is needed without interfering with each other.

### Quick aside on dependency management

In addition to isolating your environments, it's very important to keep track of what packages your project depends on i.e. its **dependencies**. Let's imagine a scenario where you are working on **Project C**, and it is using version 1.0.2 of `numpy` and version 1.0.4 of `scipy` (these numbers are all made up). Everything is working great. Let's say you then upgrade these packages to versions 1.1.2 for `numpy` and 1.1.3 for `scipy`. All of a sudden something in your project is not working anymore! We couldn't be sure which update broke our code so we would have to systematically revert the updates until we found which one broke our project. In this example, it probably wouldn't be too burdensome because we only have two packages. Imagine in real life though when you have may have dozens or even hundreds of dependencies. You can no longer do this manually (and stay sane).

An even more pernicious error that can arise is let's say you updated **ONLY** the `scipy` package and this broke your code. No problem you might say, I'll simply revert the update. However upon reverting the update, your code still isn't working. How can this be? Well the `scipy` package has its own dependencies which might get upgraded in the course of updating the `scipy` package. One of those updated dependencies might be causing you issues then. Perhaps your version of `numpy` depended upon an older version of a shared dependency with `scipy`?

Hopefully I have properly motivated why dependency management is important. The simplest (and potentially most effective) dependency management tool is actually `pip`. Within your virtual environment, you can call `pip freeze > requirements.txt` which snapshots or freezes all packages installed as well as their versions. You would generally do this for a given configuration of packages that you know work well together. As you update packages, you could then update the `requirements.txt` (so long as the given configuration doesn't break your code). In the future then if you move environments or if you want to share your project with someone all you would need to provide is the `requirements.txt` file, and they would just have to run `pip install -r requirements.txt` (hopefully within their virtual environment). For more details, check out the official [`pip` documentation](https://pip.pypa.io/en/stable/reference/pip_freeze/).

### Picking a virtual environment tool

Now that we hopefully have a good understanding of why we need virtual environment tools and dependency management tools, let's pick a tool to use. There are **many** (in this author's opinion, too many) options available to choose from. For this tutorial, we will be focusing on primarily `virtualenv` + `pip`. I don't have anything more to say concerning `pip` that wasn't already [covered above](#quick-aside-on-dependency-management). So below I will be going over `virtualenv`. Most of what I've seen people saying is `virtualenv` + `pip` are good places to start, and you can start adding more tools to your tool belt as your needs grow more complex. Let's quickly go over some of those other tools below:

* `venv`: To be honest, I'm still a little confused as to whether or not I should be using this piece of software or `virtualenv`. `venv` is bundled with Python nowadays, and it's considered the *official* virtual environment management tool. However, it is slower, not as extendable, and doesn't have as rich an API as `virutalenv` ([source](https://virtualenv.pypa.io/en/latest/)). In the future, I may be switching to this, or it's possible `virtualenv` and `venv` somehow merge.
* `virtualenvwrapper`: As the name suggests, it's a nifty little wrapper for `virtualenv` that allows for more easy managing of your virtual environments. [Read about it](https://virtualenvwrapper.readthedocs.io/en/latest/index.html).
* `pyenv`: This piece of software aims to make it easier to manage multiple versions of Python. It's useful for developers who may need to test their code across many different versions of Python. [Official documentation](https://github.com/pyenv/pyenv) and a [really good tutorial](https://realpython.com/intro-to-pyenv/).
  * `pyenv-virtualenv` and `pyenv-virtualenvwrapper`: These are extensions to `pyenv` written by the author of `pyenv` which allows for a convenient integration of `pyenv` with `virutalenv` and `virtualenvwrapper`.
* `poetry`: A relatively new kid on the block (it only came out in 2018). It aims to marry dependency management and virtual environment management together in a *poetic* package. [Documentation here](https://python-poetry.org/docs/).
* `conda`: You can use `conda` to segregate your development environments! I have, perhaps, a bit of an irrational aversion to Anaconda (I think it's a control thing and how much control `conda` takes out of my hands). This is certainly an option people use.

### `virtualenv`

The first step is to install `virtualenv`. We are going to use `pip` in this tutorial.

```bash
sudo /opt/python/3.8.1/bin/pip install virtualenv
```

We will then navigate to our folder of choice and type in the command `virtualenv env_name` where `env_name` is the name of the virtual environment. You can call it whatever you want really. You will see in your folder there will be a new sub-folder called `env_name` which will contain all sorts of goodies. Basically `virtualenv` just injected itself into our `PATH` so all packages will get installed into `env_name/lib`, and all executable files will get called from `env_name/bin`. Then you will want to type in `source path/to/env_name/bin/activate` which *activates* our virtual environment and turns on the injection mentioned above. To turn off the virtual environment and the injection just type `deactivate`. It's very simple. If you're curious about the workings under the hood, [head over to the docs](https://virtualenv.pypa.io/en/latest/user_guide.html#introduction).

It's pretty simple honestly.

#### Fun bonus on creating a kernel for your virtual environment.

You would just have to follow the [steps above](#how-to-install-more-than-one-kernel) for installing a kernel for a different version of Python! It's very simple and fun. How would that look like specifically? I can give a quick example for us. This allows us to program in our virtual environment without having to activate it necessarily (all from within a Jupyter environment).

```bash
sudo /path/to/env_name/bin/pip install ipykernel
/path/to/env_name/bin/python -m ipykernel install --name py3.8.1-myEnv --display-name "env_name"
```

## Conclusion

Wow, we went over a lot. Hopefully you understand by the end of this opinionated guide how to set-up Python, Jupyter, `pip`, and `virtualenv` for your system. You should feel confident and ready to start programming in Python! Check out my `setup_python.sh` script to see how I set-up Python at home. Make sure you add the directory where you want Python installed when calling the script e.g. `./setup_python.sh /opt/python/3.8.1`.
