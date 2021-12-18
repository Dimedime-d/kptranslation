Raw binary files representing graphical text used by the game. Mostly contains GBA 4bpp graphics, relative offsets, and binaries used to construct objects consisting of multiple blocks.

```.bin``` files are no different from ```.dmp``` files (they both contain raw data), with the my general convention that ```.dmp``` files were generated on their own using the files in this repo. ```.bin``` files came from elsewhere or were hand-edited by me.

Thanks to a bunch of refactoring, I was able to eliminate most of the hard-coded ```.bin``` files and instead auto-generate them. This mainly saves time with making minor edits to graphical data (ex: minigame splash screens, overworld level titles, in-level text boxes).