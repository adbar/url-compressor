#!/bin/bash

#	This script is part of the url-compressor project (https://github.com/adbar/url-compressor).
#	It is brought to you by Adrien Barbaresi.
#	It is freely available under the GNU GPL v3 license (http://www.gnu.org/licenses/gpl.html).

# All these commands could be implemented in the Pascal compressor, but they may not be worth it.
# This script could be (very) slow on long files.

#grep '^http'
#.de, .it, co.uk/ ...
# index.
# source !

./compress-urls list list.out

## NOT REALLY MAINTAINED (MAY NOT WORK) !!
< list.out grep -v 'jpeg$' |
sed -e 's/?utm_.*//g' -e 's/&amp;utm_.*//g' -e 's/\.de\//\.D/g' -e 's/\.de$/\.D/g' -e 's/2012\/0/#2/g' -e 's/blog/#C/g' -e 's/index/#I/g' -e 's/news/#N/g' -e 's/post\//#P\//g' -e 's/article\//#A\//ig' -e 's/articles\//#S\//ig' -e 's/archive/°A/g' -e 's/content/°C/g' -e 's/&amp;/\&/g' > list2.out

# 's/\.com/\.C/g' -> 's/\.com\//\.C/g' ?
