#!/bin/bash

#	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
#	It is brought to you by Adrien Barbaresi.
#	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).


read -p "Name of the file to compress: " ANSWER

fpc compress-urls.pas
fpc decompress-urls.pas

grep '^http' $ANSWER > "clean_"$ANSWER

echo "Programs compiled, list cleaned."

./compress-urls "clean_"$ANSWER "clean_"$ANSWER".out" 2
echo "Step 1 OK : file compressed."

./decompress-urls "clean_"$ANSWER".out" "clean_"$ANSWER"-2" 2
echo "Step 2 OK : file decompressed."

echo "Step 3 - list of differences :"
comm -13 "clean_"$ANSWER "clean_"$ANSWER"-2"
