#!/bin/bash


#	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
#	It is brought to you by Adrien Barbaresi.
#	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).


# Prompt instead of command-line argument
read -p "Name of the file to compress: " ANSWER


# Compile the FreePascal source files
fpc compress-urls.pas
fpc decompress-urls.pas


# Create temporary files in the /tmp folder (UNIX) and delete them on exit
tempfile() {
    tempprefix=$(basename "$0")
    mktemp /tmp/${tempprefix}.XXXXXX
}

TMP1=$(tempfile)
TMP2=$(tempfile)
trap 'rm -f $TMP1 $TMP2' EXIT


# Select valid URLs (to be replaced)
grep '^http' $ANSWER > "clean_"$ANSWER

echo "Programs compiled, list cleaned."


# Compress and decompress
./compress-urls "clean_"$ANSWER "clean_"$ANSWER".out" 2
echo "Step 1 OK : file compressed."

./decompress-urls "clean_"$ANSWER".out" "clean_"$ANSWER"-2" 2
echo "Step 2 OK : file decompressed."


# Sort the files and output the differences using UNIX-tools
echo "Step 3 - list of differences :"
sort "clean_"$ANSWER > $TMP1
sort "clean_"$ANSWER"-2" > $TMP2
comm -13 $TMP1 $TMP2
