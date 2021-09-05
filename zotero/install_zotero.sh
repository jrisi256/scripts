#!/bin/bash

wget -O zotero.tar "https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=5.0.96.3"
tar -xvf zotero.tar
sudo mv Zotero_linux-x86_64 /opt
/opt/Zotero_linux-x86_64/set_launcher_icon
ln -s /opt/Zotero_linux-x86_64/zotero.desktop ~/.local/share/applications/zotero.desktop