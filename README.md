# Scripts for setting up my dev environment
This is where I will be setting up scripts which will hopefully automate the set-up of my dev environment in the future.

## Setting up Github and private/public key pairs
Unfortunately this part cannot be automated yet (or at least I haven't found out a way to automate it yet). Thankfully it's pretty easy.

```bash
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

You will then need to copy/paste the key into your github account.

The following two links were where I learned how to set-up my keys and then add them to my Github account:

* <https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent>
* <https://help.github.com/en/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account>

Then you need to configure your local Github username and password.

```bash
git config --global user.email "you@example.com"
git config --global user.name "Your Name"
```

Everything else should be automated.

## Renaming master to main

For a variety of reasons, it seems appropriate to change the "master" branch to the "main" branch. Thankfully this is very easy to do. You can even create a new branch based off of master through (the Github interface)[https://twitter.com/peduarte/status/1271340563493720064]. You will need to run `git pull` to pull in the new branch if you created it through Github.

Once you've made your new `main` branch the default branch, you can delete the old `master` branch. To delete the branch locally run, `git branch -d master`. To delete the branch on Github, run `git push origin --delete master`.
