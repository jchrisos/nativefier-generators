#!/bin/bash

#generating app with nativefier
nativefier https://web.whatsapp.com -n WhatsApp --tray --single-instance --maximize

#fixing package json app name
export PACKAGE_JSON=$PWD'/WhatsApp-linux-x64/resources/app/package.json'

tmp=$(mktemp)
jq --unbuffered '.name="WhatsApp"' $PACKAGE_JSON > "$tmp" && mv "$tmp" $PACKAGE_JSON

cat $PACKAGE_JSON

#creating desktop entry
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]=whatsapp-desktop
Name[en_US]=WhatsApp
Exec='$PWD'/WhatsApp-linux-x64/WhatsApp
Comment[en_US]=WhatsApp Web
Name=WhatsApp
Comment=WhatsApp Web
Icon=whatsapp-desktop' >| ~/.local/share/applications/WhatsApp.desktop