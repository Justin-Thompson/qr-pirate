#!/bin/bash
# crawling search engines for images matching description
./qrcrawler.py "$1"

# convert all images to PNG
printf "converting images to PNG. this may take a while...\n"
for pathname in ./qrbooty/google/*; do filename=$(basename "$pathname"); mv "$pathname" "./qrbooty/google_$filename"; done
for pathname in ./qrbooty/bing/*; do filename=$(basename "$pathname"); mv "$pathname" "./qrbooty/bing_$filename"; done
for pathname in ./qrbooty/baidu/*; do filename=$(basename "$pathname"); mv "$pathname" "./qrbooty/baidu_$filename"; done
mogrify -format png ./qrbooty/*.*
printf "converting done.\n\n"

# read private keys from QR codes in images
./qr2key.py

# remove duplicates
sort keylist.txt | uniq > keylist_unique.txt
