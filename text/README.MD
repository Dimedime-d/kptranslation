Some hacks that insert custom text in the game. I am using armips directives to insert every string according to the various table files included.

* `ascii.asm` adjusts text displayed in the smaller font (see: Top 3 leaderboards, "Press Start" prompt, file select menu, or the credits)
* `menu.asm` patches in English strings to the in-game menus, including multiplayer
* `dialogue.asm` and `credits.asm` contain many `equ` directives for English strings to replace the dialogue or credits, respectively.
* `insertscripts.asm` repoints some scriptcode and has additional scripting edits (such as faster text speed or increasing # of characters per line)