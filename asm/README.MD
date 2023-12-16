My assembly injections to make the translation work.

* `scriptcode/` contains ***entire cutscenes*** that I dumped from the game, using directives to dynamically insert English text. This allows me to put any arbitrary (English) text into the cutscenes.
* `customcode.asm` currently uses free space located at $B0000 to implement the following:
  * Adding variable widths to SHIFT-JIS characters that are both displayed "scrolling", one by one over time (intro, dialogue) as well as characters that are displayed statically (menus)
  * Auto-centering text
  * Re-watching cutscenes in Practice Mode
  * Custom interface for Magic Trick Instructions
* `vwfalpha.asm` does the following:
  * Repoints the font used by the game (I'm using the "thin" font over the thicker one)
  * Injects some code for the game to continue execution to my asm hooks
  * Imports some English character graphics with corrected x/y positions and offsets
  * A hook to display menu texts and add variable width to the fonts
  * More hooks for Practice Mode Menu and Magic Trick hacks