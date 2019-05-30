#!/bin/bash

wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    true
else
    echo "no internet connection"
    exit 1
fi

number_of_photos=1
# more photos will just bring previous days photos
day_index=$1
# today is zero, yesterday 1, tmrw -1

nb=$number_of_photos

idx=$day_index
if [ -z $day_index ]
  then
  idx=0
fi

urlXmlpath=$( \
curl -s "https://www.bing.com/HPImageArchive.aspx?format=rss&idx=${idx}&n=${nb}&mkt=en-US" \
| xmllint --xpath "/rss/channel/item/link/text()" - \
| sed 's/1366x768/1920x1080/g' \
)
echo Wallpaper name is
curl -s "https://www.bing.com/HPImageArchive.aspx?format=js&idx=${idx}&n=${nb}&mkt=en-US" | jq '.images[0].copyright'

read -p "Wanna apply it? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
curl -s "https://www.bing.com$urlXmlpath" | feh --bg-fill - && echo applied succesfully
fi