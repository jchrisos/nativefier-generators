#!/bin/bash

#generating app with nativefier
nativefier https://jira.atlassian.com $1 -n Jira --internal-urls "".*?\.atlassian\.*?"" --tray --single-instance --maximize

DIR=$PWD
if [[ ! -z $1 ]]; then
    DIR=$1
fi

#fixing package json app name
PACKAGE_JSON=$DIR'/Jira-linux-x64/resources/app/package.json'

tmp=$(mktemp)
jq --unbuffered '.name="Jira"' $PACKAGE_JSON > "$tmp" && mv "$tmp" $PACKAGE_JSON

#creating desktop entry
echo '#!/usr/bin/env xdg-open
[Desktop Entry]
Version=1.0
Type=Application
Terminal=false
Icon[en_US]='$DIR'/Jira-linux-x64/resources/app/icon.png
Name[en_US]=Jira
Exec='$DIR'/Jira-linux-x64/Jira
Comment[en_US]=Jira Web
Name=Jira
Comment=Jira Web
Icon='$DIR'/Jira-linux-x64/resources/app/icon.png' >| ~/.local/share/applications/Jira.desktop