#!/bin/bash

#	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
#	It is brought to you by Adrien Barbaresi.
#	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).


fpc compress-urls.pas 
fpc decompress-urls.pas 

./compress-urls list list.out 2
./decompress-urls list.out list2 2

comm -13 list list2
