#!/bin/bash

sudo snap install code --classic

# install extensions

# Spellchecker
# ext install ban.spellright
# download dictionary (.dic and .aff) from here https://github.com/titoBouzout/Dictionaries into $HOME/.config/Code/Dictionaries/
# Alternatively, just link existing dictionary (so long as it is using UTF-8, check *.aff file's first line which should be something like SET UTF-8) ln -s /usr/share/hunspell $HOME/.config/Code/Dictionaries
# Make sure to set the dictionary in the bottom-right hand corner of the blue status bar

# Markdown previewer
# Extensions: Install from VSIX...

# Markdown linter
# ext install markdownlint