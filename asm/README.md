Beware my godawful asm code.

## File Overview

* ascii.asm replaces most of the text in the small (8x8) font, which is encoded in ASCII. There's also some changes to the menu buttons
* customcode.asm currently uses free space located at $B0000 to implement the following:
  * Adding variable widths to SHIFT-JIS characters that are both displayed "scrolling", one by one over time (intro, dialogue) as well as characters that are displayed statically (menus)
  * Auto-centering text
* vwfInstaText.asm contains some script-code that adds the vwf command to text displayed instantly.
  * Currently used in one instance, "To the Helirin!", and kept separate from the times in the intro, which are also displayed instantly.
* vwfalpha.asm does the following:
  * Repoints the font used by the game (I'm using the "thin" font over the thicker one)
  * Injects some code for the game to continue execution to my asm hooks
  * Imports some English character graphics with corrected x/y positions and offsets
  * Rewrites the max # of characters per line (16 -> 32)
  * A hook to make menu texts add variable width
