#!/bin/bash

default=$(shuf -n 1 subreddits)
sub=${1:-$default}

pattern="http://i.imgur.com.\w{0,}.jpg"
url=$(curl -s "https://www.reddit.com/r/$sub/top" | grep -Eo $pattern | shuf -n 1)

filename=$(echo $url | grep -Eo "\w{0,}.jpg")
wget -q $url

if [ ! -d $HOME/reddit_backgrounds ]
then
    mkdir $HOME/reddit_backgrounds
fi

mv $filename $HOME/reddit_backgrounds/.
background=$HOME/reddit_backgrounds/$filename
# use echo $DESKTOP_SESSION to determine desktop used. If $DESKTOP_SESSION does not work, try $GDMSESSION or $XDG_CURRENT_DESKTOP
case "$DESKTOP_SESSION" in
'xfce')
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set $background
;;
'mate')
    gsettings set org.mate.background picture-filename $background
;;
'gnome')
    gesttings set org.gnome.desktop.background picture-uri file:///$background
;;
*)
    notify-send "Unsupported desktop environment."
    exit
;;
esac
notify-send "Today's wallpaper is from /r/"$sub

