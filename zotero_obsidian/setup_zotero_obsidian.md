# Linking Zotero and Obsidian

This is a guide for getting Obsidian and Zotero to work together.

## Zotero plugins

To download any of these plugins, refer to the script I have set up. Then, install the plugin into Zotero (Tools, Add-ons, Install Add-on From File...).

* [Better Bibtex](https://retorque.re/zotero-better-bibtex/). This plugin is used used for generating unique citation keys to be able to uniquely reference and find any research paper.
* [Mdnotes](https://argentinaos.com/zotero-mdnotes/). This plugin intelligently exports Zotero metadata, notes, and annotations as markdown files which we can then integrate into Obsidian.
* [Zotfile](http://zotfile.com/). This plugin manages the attachments of a specific source. Specifically, it allows for the automatic renaming, moving, and attaching of PDFs (or other files) to Zotero items. It is also useful for syncing PDFs from your Zotero library to your (mobile) PDF reader (e.g. an iPad, Android tablet, etc.).
* * [Inciteful](https://inciteful.xyz/). This plugin is not actually related to making Zotero and Obsidian play nice with each other. It is a new tool I found that helps with literature reviews. **Note** that I found only version 0.0.8 works with Zotero 7 and not the latest version (0.0.9 as of this writing).

**Update for 2024, Zotero 7**: Both mdnotes and zotfile have stopped working due to the Zotero 7 upddate. As a result, I no longer use these plugins in my workflow. Some interesting plugins which are being billed as a replacements to Zotfile are: [ZotMoov](https://github.com/wileyyugioh/zotmoov) and [PDF Custom Rename](https://github.com/Theigrams/zotero-pdf-custom-rename?tab=readme-ov-file). Setting up Google Drive Cloud Storage on Ubuntu is a bit of a pain so ZotMoov is not super useful for me at this point in time. The PDF Custom Rename plugin also seems to largely duplicate the functionality already present in Zotero. Future updates may make it more useful.

## Obsidian plugins

Installing plugins for Obsidian is done through their interface, and it is pretty easy and straightforward.

* [Zotero Integration](https://github.com/mgmeyers/obsidian-zotero-integration). This is the newer plugin and seems like the one I should be using. It allows for links to be clicked on within Obsidian and the corresponding paper or note should open up in Zotero.
* [Dataview][https://blacksmithgu.github.io/obsidian-dataview/]. This turns your Obsidian vault into a database which you can run queries on.
* [Better Word Count](https://github.com/lukeleppan/better-word-count). This is a nice little plugin which improves upon the built-in word counter from Obsidian. The thing I like most about it is that it allows for tracking of other items other than words and characters (e.g., sentences). It also will dynamically update to keep track of the number of characters/words of highlighted sections.
* [Excalidraw](https://github.com/zsviczian/obsidian-excalidraw-plugin). This is a great plugin for creating custom drawings as well as entire canvases.
* [Citations](https://github.com/hans/obsidian-citation-plugin). This has replaced Zotfile + Mdnotes for me. It is not as feature-rich, but it accomplishes the job I want. Namely, it is able to easily create a note using metadata from Zotero for a specific article.

## Settings

The most laborious part of the setup is tweaking the settings in Zotero and Obsidian to get the exact right behavior I would like. Below, I will detail as best as I can the settings I have changed from the defaults to get the behaviors I like.

### Zotero settings

#### General

Go to Edit -> Settings -> General.

* Uncheck "Automatically take snapshots when creating items from web pages."
* Change the "Customize Filename Format" to match the Bibtex key. **Note that as of December 2024, this has not been implemented in any plugins, and I have not taken the time to figure out how to match Zotero's name generator to Better Bibtex. Renaming PDFs is not really that important, and it would just be an aesthetic thing at this point.**

#### Advanced

To access the advanced settings in Zotero, Edit, Preferences, Advanced, Config Editor.

* **extensions.zotero.export.quickCopy.setting**: When you *quick copy* an item, this setting controls what the default bibliography formatting style should be. I change this to the appropriate format. The much easier way of setting this setting is Edit, Preferences, Export, and then choose the formatting style you would like.
* **extensions.zotero.recursiveCollections**: This setting allows for all items in a sub-collection to be viewed in the parent collection. I set this value to true.

#### Zotfile settings (no longer relevant as of 2024 due to incompatibility with Zotero 7)

Change some hidden options in the Config Editor:

* **extensions.zotfile.tablet.tag**: No value.
* **extensions.zotfile.tablet.tagModified**: No value.
* **extensions.zotfile.tablet.tagParentPull_tag**: No value.

Then go into Tools, ZotFile Preferences, Tablet Settings:

* Click *Use ZotFile to send and get files from tablet*.
* Choose as a base folder: */Google Drive/Onyx Boox/Onyx Documents*.
* Make sure *No subfolders* is selected.
* Make sure *Rename files when they are sent to the tablet** is not selected.
* Make sure *Automatically extract annotations when getting PDFs back from tablet* is not selected.

Then go into Tools, ZotFile Preferences, Renaming Rules:

* Change the format of the renaming rules to be: `%b`. This ensures all PDF files get automatically renamed to their Bibtex key.

#### Mdnotes placeholders and template files (no longer relevant as of 2024 due to incompatibility with Zotero 7)

Mdnotes is a powerful for exporting your notes and annotations from a paper into markdown. Zotero has made great strides in terms of making this functionality available in base Zotero (both in terms of extracting annotations and exporting your notes as markdown). It has gotten so good that the Mdnotes and Zotfile plugins may not be totally necessary anymore. Regardless, I started out using this plugin based workflow, and I will stick with it for the time being.

Mdnotes provides a lot of functionality for how you want Zotero to export your notes to markdown. You can specify exactly how your notes should be exported using templates. The template files for Mdnotes are included in this directory. These template files need to be pointed to within the Mdfiles settings within Zotero. This ensures that notes and papers are properly imported into Obsidian.

Specifically, Mdnotes templates work using *placeholders* which is a Mdnotes specific idea. Placeholders are a way to refer to Zotero-specific metadata about the notes you are exporting, and then subsequently structure them as you see fit. Below I will detail the specific placeholders I setup in the Config Editor for Zotero.

I will not be explaining here what these settings do exactly. Suffice to say, they create new placeholders or modify existing placeholders so that when I reference them in my template, they are in the exact format I want. If you wish to learn more or remind yourself of what you did here, you should consult the following links from the official Mdnotes documentation:

* [The default template from Mdnotes](https://argentinaos.com/zotero-mdnotes/docs/advanced/templates/defaults/).
* [Template for single-file workflow](https://argentinaos.com/zotero-mdnotes/docs/advanced/templates/single-file).
* [A guide to placeholders](https://argentinaos.com/zotero-mdnotes/docs/advanced/placeholders/).
* [Creating your own placeholders](https://argentinaos.com/zotero-mdnotes/docs/advanced/formatting/).

Here are the settings I created:

* **extensions.mdnotes.placeholder.abstractNote**: {"content":"## Abstract\n\n{{field_contents}}", "field_contents": "{{content}}", "link_style": "no-links", "list_separator": ", "}
* **extensions.mdnotes.placeholder.author**: {"content":"{{field_contents}}", "link_style": "no-links", "list_separator": ", "}
* **extensions.mdnotes.placeholder.authorYaml**: {"content":"[{{field_contents}}]", "zotero_field":"author", "link_style": "no-links", "list_separator": ", "}
* **extensions.mdnotes.placeholder.citekey**: {"content":"{{field_contents}}", "field_contents": "{{content}}", "link_style": "no-links"}
* **extensions.mdnotes.placeholder.date**: {"content":"{{field_contents}}", "link_style": "no-links", "list_separator": ", "}
* **extensions.mdnotes.placeholder.issue**: {"content":"{{field_contents}}", "link_style": "no-links", "list_separator": ", "}
* **extensions.mdnotes.placeholder.itemTypeYaml**: {"content":"[{{field_contents}}]", "link_style": "no-links", "list_separator": ", ", "zotero_field":"itemType"}
* **extensions.mdnotes.placeholder.noteContent**: {"content":"{{field_contents}}", "link_style":"markdown"}
* **extensions.mdnotes.placeholder.notes**: {"content":"{{field_contents}}", "field_contents": "{{content}}", "link_style": "wiki", "list_separator": "\n- "}
* **extensions.mdnotes.placeholder.pages**: {"content":"{{field_contents}}", "link_style": "no-links", "list_separator": ", "}
* **extensions.mdnotes.placeholder.pdfAttachments**: {"content":"{{field_contents}}", "field_contents": "{{content}}", "list_separator": "\n\t- "}
* **extensions.mdnotes.placeholder.publicationTitle**: {"content":"{{field_contents}}", "link_style": "no-links", "list_separator": ", "}
* **extensions.mdnotes.placeholder.publicationTitleYaml**: {"content":"[{{field_contents}}]", "link_style": "no-links", "list_separator": ", ", "zotero_field":"publicationTitle"}
* **extensions.mdnotes.placeholder.tags**: {"content":"{{field_contents}}", "field_contents": "#{{content}}", "link_style": "no-links", "list_separator": ", ", "remove_spaces": "true"}
* **extensions.mdnotes.placeholder.title**: {"content": "{{field_contents}}", "link_style": "no-links"}
* **extensions.mdnotes.placeholder.url**: {"content":"{{field_contents}}", "field_contents": "{{content}}"}
* **extensions.mdnotes.placeholder.volume**: {"content":"{{field_contents}}", "link_style": "no-links", "list_separator": ", "}

#### Mdnotes preferences (no longer relevant as of 2024 due to incompatibility with Zotero 7)

If you click on Tools and then Mdnotes preferences, you will be able to set a bunch of settings.

* Change *File Organization* to *Single file*. In the Config Editor, it would be changing **extensions.mdnotes.file_conf** to single.
* Change *Internal Links* to *No links*. In the Config Editor, it would be changing **extensions.mdnotes.link_style** to none.
* Set the appropriate *export directory* (e.g., /home/joe/Documents/obsidian/joe_shack_home). In the Config Editor, it would be changing **extensions.mdnotes.directory** to the appropriate directory.
* Set the appropriate *Template folder* (/home/joe/Documents/scripts/zotero_obsidian). In the Config Editor, it would be changing **extensions.mdnotes.templates.directory** to the appropriate directory.
* Make sure *Attach file links to Zotero* is checked off. In the Config Editor, it would be changing **extensions.mdnotes.attach_to_zotero** to false.

### Obsidian settings

* Settings (Gear), Editor:
  * **Show frontmatter**: Turn on.
  * **Show line number**: Turn on.
* Settings (Gear), Files & Links:
  * **Confirm file deletion**: Turn off.
  * **Detect file extensions**: Turn on.
* Settings (Gear), Core plugins:
  * **Audio recorder**: Turn on.
  * **Daily notes**: Turn off.
  * **Slash commands**: Turn on.
  * **Slides**: Turn on.
* Settings (Gear), Core Plugins (Quick switcher):
  * **Show all file types**: Turn on.
* Settings (Gear), Community Plugins (Zotero Integration):
  * **Enable Cite Key Autocomplete**: Turn on.
* Settings (Gear), Community Plugins (Citations):
  * Change **Citation database format** to BibLaTeX.
  * Go into Zotero -> File -> Export Library -> change format to Better BibTeX --> Check *Keep Updated* -> then save the file in my obsidian vault.
  * In the Citations plugin, set the path of the library.
  * Set the default folder where notes will be stored.
  * Finally set the template for how notes will be created. This is my preferred template:

> title: "{{title}}"
> author: {{authorString}}
> year: {{year}}
> journal: {{containerTitle}}
> type: {{entry.type}}
> [Zotero entry]({{zoteroSelectURI}})
> **Tags**:
> ## Abstract
> {{abstract}}
