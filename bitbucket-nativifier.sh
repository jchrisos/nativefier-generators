#!/bin/bash

#generating app with nativefier
nativefier https://bitbucket.org/account/signin/ $1 -n Bitbucket --internal-urls "".*?\.atlassian\.*?"" --single-instance --maximize

DIR=$PWD
if [[ ! -z $1 ]]; then
    DIR=$1
fi

#fixing package json app name
PACKAGE_JSON=$DIR'/Bitbucket-linux-x64/resources/app/package.json'

tmp=$(mktemp)
jq --unbuffered '.name="Bitbucket"' $PACKAGE_JSON > "$tmp" && mv "$tmp" $PACKAGE_JSON

#creating desktop entry
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]='$DIR'/Bitbucket-linux-x64/resources/app/icon.png
Name[en_US]=Bitbucket
Exec='$DIR'/Bitbucket-linux-x64/Bitbucket
Comment[en_US]=Bitbucket Web
Name=Bitbucket
Comment=Bitbucket Web
Icon='$DIR'/Bitbucket-linux-x64/resources/app/icon.png' >| ~/.local/share/applications/Bitbucket.desktop