# The start-up routine of your shell environment

If you're like me, you've probably come across these files in the course of your learning: `.profile`, `.bash_profile`, and .`.bashrc`. If you're like me, you've probably also wondered what the heck do these files do? It's really quite simple, and below I'll detail what each of these files do.

When you log-in to a Unix or Unix-like system, the system starts up one program for you which is known as **the command line shell**. It's a program designed to run other programs. One of the most popular command line shells is **Bash**. However, it's important to keep in mind there are other types of command line shells even if they're not as popular as Bash.

## `.profile`

This file is designed to cover everything not specific or related to the Bash shell (as all types of shells make use of it). Typically, this is where people place their environment variables.

## `.bashrc`

This file is designed for configuring your interactive Bash session. You can set-up specific Bash aliases here, set your favorite text editor, set your favorite Bash prompt, etc.

## `.bash_profile`

This functions similarly to `.profile` however only the Bash command line shell looks for it. If it doesn't exist, `.profile` is used. Typically people don't create this file or just have it source `.profile` and `.bashrc`.

## End notes and links

The most consistent set of best practices I've seen recommended is basically:

* Set all your non-Bash environment variables in `.profile`.
* Source `.bashrc` from `.profile`.
* Ignore everything else unless you have very specific use cases for them.

This article was only really focused on practical concerns and as a result stays very high-level. As I get more familiar with these tools, I may adjust it accordingly. Additionally, I'll provide some links below for those who want to dig deeper.

* [Excellent blog post with great visuals explaining the command line shell start-up routine](https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/)
* [In-depth forum discussion concerning these issues](https://superuser.com/questions/789448/choosing-between-bashrc-profile-bash-profile-etc)
* [Another in-depth forum discussion concerning these issues](https://superuser.com/questions/183870/difference-between-bashrc-and-bash-profile)
* [Yet another in-depth forum discussion (still helpful)](https://serverfault.com/questions/261802/what-are-the-functional-differences-between-profile-bash-profile-and-bashrc)
