# Renvirons, Rprofiles, and Libraries

## Renvirons

What are Renviron files? They are files which specify certain R-specific environment variables. During the R start-up process, R will read in operating system (OS) environment variables (which can be accessed with `Sys.getenv("VAR_NAME")`). Then it will also read in Renviron files for additional environment variables specific to R (these variables can also be accessed with `Sys.getenv()`). As far as I can tell, R treats OS environment variables and environment variables from Renviron files the same.

Renviron files are **plain-text files** meaning they are not R code. Each line takes the form of `name=value`. You can comment out things with `#`.

Finally, there will be **user-level** and **site-level** Renvirons (and Rprofiles and libraries). **User-level** refers to the individual user and how only the individual user starting the given R session will have access to the specified resources. **Site-level** refers to all users across a given site and how all of them will have access to the specific resources (mainly useful for admins who are managing an environment for a group of users).

### Renviron start-up process

1. Was `--no-environ` set on the command line? If so, do not search for site and user files to process environmental variables.
2. If `--no-environ` was not set, check the environment variable `R_ENVIRON` for the path to the site environment file.
    + I assume `R_ENVIRON` has to be an OS environment variable because I'm not sure where else you could set it. I suppose you could set it in `R_HOME/etc/Renviron`, but everywhere I've read says you should not edit that file.
3. If `R_ENVIRON` is unset (which by default it is), go to `R_HOME/etc/Renviron.site` and check for environment variables to set for your R session.
    + Sometimes `Renviron.site` will exist by default and other times it will not. Do no worry either way if it is set up or not.
4. Next check the `R_ENVIRON_USER` environment variable for the path to the user environment file.
    + This can be set either in the site-level environment file (although it wouldn't make much sense to set the same user file for all users), or it can be set using an OS level environment variable (probably the better way to do it).
5. If the `R_ENVIRON_USER` environment variable is unset (which by default it is), then check R's current working directory for a `.Renviron` file. Generally this is where an R project's `.Renviron` file will be pulled in.
6. If R's current working directory does not have a `.Renviron` file, look in the user's home directory, `~/.Renviron`.

### Notes on Renvirons

* You may be asking yourself, "What is this `R_HOME` I keep seeing pop up?" `R_HOME` is an environment variable set by R. It is simply the top-level directory for your R installation or R's *home*. You can find out the `R_HOME` path by typing `Sys.getenv("R_HOME")` in an R session, typing `R.home()` in an R session, or by typing `R RHOME` in the terminal.
* A site-wide file and EITHER an R project or user Renviron can be loaded at the same time. You cannot have a project Renviron and a user Renviron loaded at the same time.
* On Unix/GNU-Linux versions of R, there is a file `R_HOME/etc/Renviron` which is read very early in the start-up process. It contains environment variables set by R in the configure process. Values in that file can be overridden in site or user environment files. The Renviron file SHOULD NOT be changed itself.
* What sorts of things do people put in their Renviron files? Generally people put API keys or other sensitive information so they can share code without exposing that sensitive information (anywhere in the code which needs the key you can use `Sys.getenv("API_KEY")`). For other use cases refer to the [links at the bottom of the section](#links-for-better-understanding-rprofiles-and-renvirons).
* The above note should indicate you generally (but not always) do not want to share your Renviron file through something like Github. You can add your Renviron to your `.gitignore` file.
* You should not set-up/use your Renviron file in such a way so as to reduce the portability/reproducibility of your code.

## Rprofiles

After the Renviron files are read and processed, R moves on to processing Rprofiles. What are Rprofiles? Unlike Renvirons, Rprofiles are **R scripts**, and as a result you write R code in them. What kind of R code is usually included in an Rprofile? Sometimes people put fun things in their Rprofiles to customize their R experience. Other times people use them when they're working on a team so everybody is downloading packages from the same repository. Use cases vary, but one can gain a better idea of what Rprofiles are used for by exploring the [links at the bottom of the section](#links-for-better-understanding-rprofiles-and-renvirons).

It's also widely discouraged from adding R code to your Rprofile which would limit the portability/reproducibility of your code (e.g. defining a function which you use again and again across many different projects).

### Rprofile start-up process

1. Was `--no-site-file` set at the command line? If so, do not search for a site-wide Rprofile.
2. If it was not set, check the `R_PROFILE` environment variable for the location of the site-wide Rprofile.
    + You can set this value at the OS level, or in one of your `.Renviron` or `Renviron.site` files. I suppose the benefits of setting this variable at the OS level is it will be easier for non-R processes to access this variable. Alternatively one could set it in an `.Renviron` or `Renviron.site` file to keep all R-related items together. Either way is fine, and it'll work the same no matter how it's set-up.
3. If `R_PROFILE` is unset (which it is by default) check `R_HOME/etc/Rprofile.site`. This file may or may or may not exist by default to start. It is no cause for concern either way.
4. Was `--no-init-file` set at the command line? If so, do not look for a user Rprofile.
5. If it was not set, check the value of the environment variable `R_PROFILE_USER` for the path to the user's Rprofile.
    + Like above for `R_PROFILE`, you can set this at the OS level, or in one of your `.Renviron` or `Renviron.site` files.
6. If `R_PROFILE_USER` is undefined (by default it is), check R's current working directory for `.Rprofile`. Generally speaking this is where a project's `.Rprofile` will be stored.
7. If no `.Rprofile` is found in R's current working directory, check the user's home directory `~/.Rprofile`.

Similar to Renvirons, a site-wide Rprofile and EITHER an R project Rprofile or user Rprofile can be loaded at the same time. You cannot have a project Rprofile and a user Rprofile loaded at the same time.

## Links for better understanding Rprofiles and Renvirons

* [Official documentation from R concerning its start-up process around Rprofiles and Renvirons](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Startup.html)
* [Excerpt from the *Efficient R Programming* book concerning Rprofiles and Renvirons](https://csgillespie.github.io/efficientR/set-up.html#r-startup)
    + Here is an [additional excerpt](https://csgillespie.github.io/efficientR/3-3-r-startup.html#r-startup) from an older (I think) version of the book.
* [Deeper dive on Rprofiles and Renvirons provided by RStudio](https://rviews.rstudio.com/2017/04/19/r-for-enterprise-understanding-r-s-startup/). It goes into some interesting use cases for Rprofiles and Renvirons.
* [Excerpt from the *What They Forgot To Teach You About R* Book concerning Rprofiles and Renvirons](https://rstats.wtf/r-startup.html). It has a very useful (although intimidating at first glance) diagram of R's start-up process.
* [For the curious who are interested in using environment variables in the OS](https://devconnected.com/how-to-set-and-unset-environment-variables-on-linux/)
* [Useful list of environment variables which affect R](https://stat.ethz.ch/R-manual/R-devel/library/base/html/EnvVar.html)

## Libraries
What is a library? In the words of [Hadley Wickham](http://r-pkgs.had.co.nz/package.html), a library is simply a directory containing installed packages (side-note this link is very useful, in general, because it gives a very good overview of packages and the different types of packages).

Why should you be concerned with libraries? The power of R largely comes from its extensibility through packages. Managing your libraries is important then to ensure all of your packages play nice together which ensures your code works.

### Where are my packages currently being stored?

* The **library search path** (or where R looks for your installed packages) is initialized at start-up from a variety of different sources each taking a different priority. This means if one happens to have multiple versions of an R package installed, libraries with higher priority will have their version of the package loaded. It also means when packages are being installed, they will be installed into the library with the highest priority.
    1. The library paths specified by the environment variable `R_LIBS` take the highest precedence. The use case for this environment variable is a bit unclear to me. It seems as if the most appropriate use case is if there are site libraries that you want to take precedence over users' libraries.
        + By default, `R_LIBS` is unset.
    2. The library paths specified by the environment variable `R_LIBS_USER` are next highest. This should point to a user's respective libraries.
        + By default (on GNU-Linux systems), this is set to `~/R/R.version$platform-library/x.y` where *x.y* refers to the version of R being used (e.g. 3.4).
    3. Next in terms of priority are the library paths specified by the R variable `.Library.site`. How it gets set:
        
        + Is the environment variable `R_LIBS_SITE` set? If so, set the value of `.Library.site` to `R_LIBS_SITE`.
        + If `R_LIBS_SITE` is not set, `.Library.site` defaults to `R_HOME/site-library`.
        + If `R_HOME/site-library` does not exist, `.Library.site` does not get set. As a result, there are no site libraries.
        
        &nbsp;
    4. Last in terms of priority is the path returned by the R variable `.Library` which is `R_HOME/library`. Generally speaking this is where the default R packages (which came in the initial R download and installation) are kept.
        + The value for `.Library` cannot be changed.
* To see your library search path, you can use the `.libPaths()` function in an R session. When you don't provide any arguments, it will provide the current library search path which will generally look like `unique(c(R_LIBS, R_LIBS_USER, .Library.site, .Library))` with the first item having the highest priority. You can also do `.libPaths(new)` which designates a **new** directory to include in your library search path. Interestingly the library search path looks like `unique(c(new, .Library.site, .Library))` after providing an argument for `new`. This means the directories designated by `R_LIBS` and `R_LIBS_USER` are no longer part of the search path.

### Notes on libraries

* I've seen some places on the internet suggesting you set `Library.site` in an `.Rprofile` or `Rprofile.site`. In my experience, this does not work well and leads to odd behavior so I wouldn't recommend it. However, it could be because I don't have a complete enough understanding of R's start-up processes. In any case, I encourage further experimentation and maybe someone can achieve better results than I was able to using this method.
* I have additionally seen some places on the internet suggesting you set `libPaths()` directly in an Rprofile. For example, `libPaths(c("path1", "path2"))` or even `.libPaths(c("path1", .libPaths()))`. This method does technically work and generally does not lead to the odd behavior which can sometimes happen when trying to set `.Library.site` directly. However, I'm not exactly sure what this approach offers over setting these values directly using the environment variables mentioned above. Since the R environment variables are provided, it makes more sense to me to use them. I also wouldn't recommend mixing methods either because (at least for me) it would get too confusing to keep track of everything.
* All of the environment variables should be a colon-separated list of directories. All the directories must also be valid otherwise R **silently** ignores them. In other words, R will not display any messages or warnings that a path was not valid (does not exist). This is a subtle but important point. I've banged my head against the wall so many times because a library was not showing up in .libPaths() only to realize I had typed in the path incorrectly.
    + This also leads to interesting behavior when running R as a sudo user. For example, if `R_LIBS_USER` is the default `~/R/R.version$platform-library/x.y` then this path will be invalid when run as sudo (since your ~ directory is different as yourself vs. root, and I'm assuming this library does not exist in root's home directory). As a result, it will not show up in your .libPaths(). Of course, this also depends on which version of GNU-Linux one is using since different operating systems treat `sudo` and `su` differently. As of the time of this writing for example, if I ran `sudo R` on Ubuntu 18.04 my `R_LIBS_USER` libraries still showed up. If I ran `sudo su` then `R`, my `R_LIBS_USER` libraries did not show up. Contrast this with Red Hat 8 where both `sudo R` and then `sudo su` followed by `R` resulted in my `R_LIBS_USER` libraries not showing up.
* Only **one** version of each R package can be installed and accessed in a given library at a time.
* An R library is tied to a specific version of R meaning unexpected behavior can result in trying to load a package from a library associated with a version of R different from the one you are using.
    + I did some playing around with this and found packages installed under R version 3.5.x were not compatiable with R version 3.6.x, for example. I also found a warning would be issued when a package was installed under 3.6.1 but then accessed under 3.6.0, for example. This pattern held anytime an older version of R tried to access a package installed under a newer version of R. However, I didn't seem to find any issues if I installed a package under 3.6.0 and tried to access it in later versions of 3.6.x such as 3.6.2, for example. If you installed a package under an older version of R, the newer version wouldn't complain.
* On some GNU-Linux systems, there are a bunch of site libraries defined by default under `R_LIBS_SITE`. I was confused as to what was the difference between all of them so I after some searching, I found [the answer](https://stat.ethz.ch/pipermail/r-help/2003-October/041178.html) which I will document here:

    + `/usr/lib/R/library` is for the default R packages which are installed using the OS package manager when downloading/installing R itself.
    + `/usr/lib/R/site-library` is for R packages installed using using the OS package manager (yum, apt, etc.).
    + `/usr/local/lib/R/site-library` is for R packages installed using R.
        
### Links for better understanding libraries
* [A fellow R user who was just as confused as I was when I first started learning about libraries has their questions answered](https://community.rstudio.com/t/help-regarding-package-installation-renviron-rprofile-r-libs-r-libs-site-and-r-libs-user-oh-my/13888)
* [This is for Windows but still very informative for understanding libraries, and it also has a helpful video](http://www.quintuitive.com/2018/03/31/package-paths-r/)
* [Official R documentation concerning libraries and the library search path](https://stat.ethz.ch/R-manual/R-devel/library/base/html/libPaths.html)

## The renv package

This may be a bit out of scope, but it is related to libraries. `renv` is an amazing R package designed to capture project-level R dependencies. First, let's motivate why this package is necessary and what problem it is trying to solve.

This [guidance from RStudio](https://environments.rstudio.com/shared.html) expertly describes the issue. Suppose on January 1st, you install the `tibble` package and all associated dependencies (`rlang`, `cli`, `crayon`, etc.). Everything is all well and good. On February 1st, you download the `pkgdown` package. It has an overlapping set of dependencies with `tibble` (`rlang`, `cli`, `crayon`, etc.). The first problem which could arise is any previous code which relied upon those dependencies may not work now because those packages have changed. The second problem is `tibble` was not updated. As a result, `tibble` may not work because the version of `tibble` currently installed was not tested on the new versions of the dependencies.

The above documentation from RStudio goes on to describe a **shared baseline** set-up where you pull from a snapshotted version of CRAN (created yourself or by using one provided by the [lovely people at MRAN](https://blog.revolutionanalytics.com/2019/05/cran-snapshots-and-you.html)). This solves the issue because every time you download a new package it comes from a stable, tested version of CRAN where all packages are guaranteed to work harmoniously together. However, it's a bit overkill for one person or a team of people. For starters, you won't be able to download any new packages or updates past the snapshot. When you do inevitably want to update, you'll have to re-download and reinstall all your packages from the new snapshot.

This is where `renv` comes into play.

### How renv works

In a bit of a chicken-and-egg problem, I believe one has to install `renv` into their local library to get the ball rolling. Once one has it set-up with their project, they can delete their local installation. One of the main points of `renv` (as far as I can tell) is to create project-level libraries which are segregated from each other and don't pollute each other so to speak. This makes maintaining a local library which spans across all projects a bit unnecessary it seems to me. I guess I could envision some use cases here and there. Really though it seems like for a variety of the work one does in R one should be doing it in an R project using `renv`.

Before we really dig in, I'll just note almost all of my notes are coming from the documentation itself for `renv` which [I link to below](#links-to-renv-documentation). I really recommend everyone read it. It's superbly written and communicates quite clearly what `renv` is doing.

The general workflow while using `renv` is as follows:

1. Call `renv::init()` to initialize a new project-level library.
2. Go about coding in R to your heart's content. Install packages, update them, and delete them.
3. When you got all the packages you need, call `renv::snapshot()` to save the state of your project-level library to `renv.lock`. A rookie mistake (which your humble author committed) is to not realize that `renv::snapshot()` only captures packages one actively invokes and uses in their project.
4. Continue working on your project as normal and add/update/delete packages as you would.
5. If your code is working well, you can call `renv::snapshot()` again to update the lock file. However if by adding/updating/deleting packages your code no longer works, you can call `renv::restore()` to restore your library from the lock file (which ideally is referencing a version of your library where your code worked).

This is how `renv` fixes the issue described above (sort of). It doesn't prevent one from entering a state where the dependencies can get all out of sync. Instead it provides a framework for users to revert back to a time when their dependencies **were** in sync. From that state, users can figure out what specifically is causing the issue.

One important thing to note is that `renv` will record which version of R is in use. It's up to the user, however, to ensure they are using the right version of R. Of course, one can use a different version of R and have no issues too.

`renv` also works with Python as [outlined here](https://rstudio.github.io/renv/articles/python.html). I assume it is adequate at capturing Python dependencies, but I imagine it may be better to use more Python-specific tools.

### `renv::init()`

`renv::init()` is doing a bunch of things I'm not going to outline here. However, I'll touch upon the **infrastructure** it creates when it is called:

1. `project_path/.Rprofile`: This ensures every new R session which is invoked in the project path activates `renv`.
2. `project_path/renv.lock`: This is a JSON file described above which captures the state of one's project library.
3. `project_path/renv/activate.R`: This the script which activates `renv`, and it is what is called in `.Rprofile`.
4. `project_path/renv/library`: The private project library.

For the purposes of collaborating (using something like Git or Github), one should be tracking `project_path/.Rprofile`, `project_path/renv.lock`, and `project_path/renv/activate.R`. I believe `renv::init()` ensures what should be ignored is placed into your `.gitignore` file.

### `renv::upgrade`

After initializing a project with `renv`, it becomes bound to that version of `renv`. To upgrade the version of `renv` associated with that project, one can use `renv::upgrade()`.

### The Global Cache

One of the great innovations `renv` brings to the table is the global cache from which all projects populate their libraries. If one looks in `project_path/renv/library`, they'll find all the packages are symbolic links to where the packages are actually stored (the global cache). The global cache ensures one only needs to download a package once (saving you time). Every other time a project needs that package, it can just reference the one in the global cache rather than downloading it again. You also save on disk space since you only need to store that package once. Additionally the global cache allows for multiple versions of each package to be stored so you can keep using whatever version of each package works for each project.

By default on Linux platforms the cache is stored under `~/.local/share/renv`. One can also set the `RENV_PATHS_CACHE` environment variable to store the cache somewhere else (and have it be used by several people if you so desire). The documentation recommends setting this in an `.Renviron` file, but it's possible it could be set like any other normal environment variable (I think, haven't tested). It may make sense to do it the recommended way so that way all R related environment variables stick together.

One can continue to use `install.packages()` and `remove.packages()` as normal. `renv` is smart enough to handle everything smoothly. For the curious, it achieves this by [using shims](https://rstudio.github.io/renv/articles/renv.html#shims).

### Links to renv documentation
There is a bunch of other stuff `renv` can do! I only outlined the major things above. By working with the package, you'll get a better sense of how it works. You may also have more questions pop up. Below are a list of resources which may be of some help in answering those and any more questions you might have.

* [Introduction to renv](https://rstudio.github.io/renv/articles/renv.html)
* [An example `renv.lock` file](https://rstudio.github.io/renv/articles/lockfile.html)
* [How renv makes it easier to collaborate/share your code](https://rstudio.github.io/renv/articles/collaborating.html). Relatedly [how one can use Git/Github to retrieve older versions of your `renv.lock` file](https://rstudio.github.io/renv/articles/renv.html#history)
* [Function reference documentation](https://rstudio.github.io/renv/reference/index.html)
