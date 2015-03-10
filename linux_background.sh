#!/bin/bash

default=$(shuf -n 1 subreddits)
sub=${1:-$default}

pattern="http://i.imgur.com.\w{0,}.jpg"
url=$(curl -s "http://www.reddit.com/r/$sub/top" | grep -Eo $pattern | shuf -n 1)

filename=$(echo $url | grep -Eo "\w{0,}.jpg")
wget -q $url

if [ ! -d $HOME/reddit_backgrounds ]
then
    mkdir $HOME/reddit_backgrounds
fi

mv $filename $HOME/reddit_backgrounds/.
background=$HOME/reddit_backgrounds/$filename
# use echo $DESKTOP_SESSION to determine desktop used. The following works if 'xfce' is returned.
if [ "$DESKTOP_SESSION" = "xfce" ];
then
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set $background
    notify-send "Today's wallpaper is from /r/"$sub -i /usr/share/pixmaps/xfce4_xicon1.png
elif [ "$DESKTOP_SESSION" = "mate" ];
then
    gsettings set org.mate.background picture-filename $background
    notify-send "Today's wallpaper is from /r/"$sub
else
    notify-send "Unsupported desktop environment."
fi
