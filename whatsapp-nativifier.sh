#!/bin/bash

#generating app with nativefier
nativefier https://web.whatsapp.com $1 -n WhatsApp --tray --single-instance --maximize

DIR=$PWD
if [[ ! -z $1 ]]; then
    DIR=$1
fi

#fixing package json app name
PACKAGE_JSON=$DIR'/WhatsApp-linux-x64/resources/app/package.json'

tmp=$(mktemp)
jq --unbuffered '.name="WhatsApp"' $PACKAGE_JSON > "$tmp" && mv "$tmp" $PACKAGE_JSON

#creating desktop entry
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]='$DIR'/WhatsApp-linux-x64/resources/app/icon.png
Name[en_US]=WhatsApp
Exec='$DIR'/WhatsApp-linux-x64/WhatsApp
Comment[en_US]=WhatsApp Web
Name=WhatsApp
Comment=WhatsApp Web
Icon='$DIR'/WhatsApp-linux-x64/resources/app/icon.png' >| ~/.local/share/applications/WhatsApp.desktop