#!/bin/bash
default=$(shuf -n 1 subreddits)
sub=${1:-$default}
echo "today's wallpaper is from /r/"$sub
pattern="http://i.imgur.com.\w{0,}.jpg"
url=$(curl -s "http://www.reddit.com/r/$sub/top" | grep -Eo $pattern | shuf -n 1)
filename=$(echo $url | grep -Eo "\w{0,}.jpg")
wget -q $url
mv $filename $HOME/pics/.

xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set $HOME/pics/$filename
