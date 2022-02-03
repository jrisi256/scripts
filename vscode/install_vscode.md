# Install Visual Studio Code Extensions

There are a number of extensions I've added to Visual Studio Code overtime to improve the programming experience. Information concerning how to install and configure theme is provided below.

## A spell checker

* To install, `ext install ban.spellright`.
* The spell checker requires a bit more set-up than other extensions. One needs to download a dictionary [from here](https://github.com/titoBouzout/Dictionaries) into `$HOME/.config/Code/Dictionaries/`. You'll want the `.dic.` and (`.aff`) files.
* Alternatively one can link an existing dictionary so long as it is using `UTF-8`. Check the `*.aff` file's first line which should be something like `SET UTF-8`. For example I did, `ln -s /usr/share/hunspell/en_US.aff $HOME/.config/Code/Dictionaries` (and the same for `en_US.dic`).
* Finally, make sure to set the dictionary within Visual Studio Code using the blue status bar in the bottom-right hand corner.

## Markdown previewer

* To install, look for `Markdown All in One by Yu Zhang`

## Markdown linter

* To install, `ext install markdownlint`

## Json Viewer

* To install, `ext install ZainChen.json`
* To install, `ext install ccimage.jsonviewer`

## CSV and TSV Viewer

* To install, `ext install GrapeCity.gc-excelviewer`