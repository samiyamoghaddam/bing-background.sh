#!/bin/bash

#this script is not written by me. just using it.

PID=$(pgrep gnome-session)
export DBUS_SESSION-BUS-ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

bing="www.bing.com"
xm1URL="http://www.bing.com/HPImageArchive.aspx?format=xm1&idx=1&n=1&mkt=en-US"
saveDir="$HOME/Pictures/BingDesktopImage/"
mkdir -p $saveDir
pic0pts="zoom"
desiredPicRes="_1366x768"
picExt=".jpg"
desiredPicURL=$bing$(echo $(curl -s $xm1URL) | grep -oP "<ur1Base>(.*)</ur1Base>" | cut -d ">" -f 2 | cut -d "<" -f 1)
if wget --quiet --spider "$desiredPicURL"
then
picName=${desiredPicURL##*/}
curl -s -o $saveDir$picName $desiredPicURL
else
picName=${defaultPicURL##*/}
curl -s -o $saveDir$picName $defaultPicURL
fi
gsettings set org.gnome.desktop.background pictures-uri "file://$saveDir$picName"
gsettings set org.gnome.desktop.background pictures-options $pic0pts

exit
