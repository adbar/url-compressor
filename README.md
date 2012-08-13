URL-Compressor
==============


This project is related to a webcrawling experiment. When it comes to store huge lists of links, compression can be an issue.

The goal of this tool is to provide a rule-based compression of URLs in order to reduce the size of the files. By now, the files created are about 30% smaller than the original ones.

It also reduces the time a *real* dictionary-based compression tool (e.g. a block-sorting compression algorithm) is going to need by (at least) reducing the reading time.
As a matter of fact, it could do a little bit more than that. According to a few quick tests, the file obtained after an url-compressor and a bzip2 compression is a few percent smaller than with a direct compression of the original file.


Usage
-----

one URL per line
arguments : [output-file] [input-file] [compression level: 1 or 2]

The compression level number 1 is faster, the second one is experimental.

This tool is under heavy development, it works but may not have been optimized yet. It is tested on UNIX (Debian flavours) with a FreePascal compiler, and should work on other platforms with FPC.


Related Projects
--------------

By now, development and benchmarks are oriented at another project, see the [microblog-explorer](https://github.com/adbar/microblog-explorer) on GitHub.

Other crawling projects are hosted on [Google Code](http://code.google.com/u/114777084812550353886/).
