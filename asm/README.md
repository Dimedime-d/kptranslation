Beware my godawful asm code.

## File Overview

* ascii.asm replaces most of the text in the small (8x8) font, which is encoded in ASCII. There's also some changes to the menu buttons
* customcode.asm currently uses free space located at $B0000 to implement the following:
  * Adding variable widths to SHIFT-JIS characters that are both displayed "scrolling", one by one over time (intro, dialogue) as well as characters that are displayed statically (menus)
  * Auto-centering text
* nextscriptpointer.asm goes through **every** script offset to make it compliant with my custom code.
  * Where the original script was at `offset`, `offset` contains a new offset to my English text (currently inserted using Atlas)
  * `offset+4` contains the next offset where the in-game script parser should pick up. (I'm partially overwriting some Japanese text)
* vwfInstaText.asm contains some script-code that adds the vwf command to text displayed instantly.
  * Currently used in one instance, "To the Helirin!", and kept separate from the times in the intro, which are also displayed instantly.
* vwfalpha.asm does the following:
  * Repoints the font used by the game (I'm using the "thin" font over the thicker one)
  * Injects some code for the game to continue execution to my asm hooks
  * Imports some English character graphics with corrected x/y positions and offsets
  * Rewrites like the max # of characters per line
