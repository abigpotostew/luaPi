### luaPi
#### By Stewart Bracken

This is an openFrameworks project intended to run on Raspberry Pi. However it should work on most platforms.

This simple program runs an ofxLua script passed in by command line.

You need my fork of the ofxLua addon with luajit installed. 

#### Usage:
``` 
make
cd bin/
./luaPi -s kaleidoscope/kaleidoscope.lua
```
Appologies for the -s option, the path to the script is based on the data/ directory being the working directory so it makes it kinda awkward to type in the script name.