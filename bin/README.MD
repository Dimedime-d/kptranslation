Raw binary files representing graphical text used by the game. Mostly contains GBA 4bpp graphics, relative offsets, and binaries used to construct objects consisting of multiple blocks.

```.bin``` files are no different from ```.dmp``` files (they both contain raw data), with the my general convention that ```.dmp``` files were generated on their own using the files in this repo. ```.bin``` files came from elsewhere or were hand-edited by me.

Thanks to a bunch of refactoring, I was able to eliminate most of the hard-coded ```.bin``` files and instead auto-generate them. This mainly saves time with making minor edits to graphical data (ex: minigame splash screens, overworld level titles, in-level text boxes).

Some of the binaries contain pre-compressed data.

* asciiwidthtable.bin
  * Custom widths for English ASCII characters. Even offsets are left-side position shifts, odd offsets are right-side ones.
* asciiwidthtable2.bin
  * Slightly modified with table. As a workaround to display lowercase ASCII characters in multiplayer modes, I do not subtract 0x20 from the glyph byte to determine object tiles/widths. This table reflects that.
* customgrade.bin
  * Custom graphics used for the suffixes on save file names when beating all the in-game records held by certain characters. Currently uses a custom palette using a yellow/orange T, B, and M.
* kkmultivramComp.bin
  * LZ Compressed VRAM data sent to child GBAs during multiplayer Kurukuru Kururin. Contains translated "Random", "Rounds", and "Minutes" text.
* kkmultivram2Comp.bin
  * Similar to the first one, except this replaces all the kana with lowercase English ASCII characters to be used.
* lowercaseascii.bin
  * Tile data of lowercase English ASCII characters. 1-Player Kurukuru Kururin does not load these characters by default, so I had to hack them in.
* minigamepausemenu.bin
  * Tile data for pause menu during a minigame. For some reason, instead of using ASCII like all other menus, minigames load a special object.
* mpObjTilesComp.bin
  * LZ Compressed VRAM data sent to child GBAs during multiplayer Minigame Paradise. This hacks in lowercase English ASCII characters.
* mpObjTilesComp2.bin
  * Similar to above, except this hacks in the pause menu.
* obj_LArrow.bin and obj_RArrow.bin
  * Copied tile data for the pink L and R arrows that appear in the overworld, re-used in the magic instructions. Have to include an additional copy of this data to alter the "header" data to position it properly.
* tenhundredobjnew.bin
  * Pre-compressed binary of new object tiles used in "Ten and Hundred" magic trick. Includes the coins and dynamic "10/100" "heads/tails" text