Contains the raw graphics I made to insert into the ROM.

My original process for inserting graphics was to make my `.png` files, manually partition them into the proper tile dimensions (16x16, 32x16, etc.), then insert them into a dummy ROM using GBA graphics editor, then export the binary graphical data and palette (these are the `.bin` files found in this repo), and insert and repoint to the new graphical data in my armips scripts.

With some refactoring with the help of `grit` to automatically format images in the right shape, I should be able to go directly from my `.png` file to a `.dmp` file that uses the original palette. Saves a lot of clicks in theory, and making small edits to the `.png`'s doesn't take too much work anymore. Check out the Python scripts inside to see how I format them.

---

* `fixed/`
  * Miscellaneous graphics that appear in the game.
* `glyphs/`
  * Tile data for standardized English character glyphs (each glyph object's tile data should have no empty space to the top or to the left), as well as a new width table.
* `inlevel/`
  * Level names that appear in blue and white as soon as you enter a level, and Kururin's little text box that appears on the bottom. Contains a python script to help format these dialog boxes quickly.
* `learnmagic`
  * Various graphics used in the Magic Menu. Contains a Python GUI to help make individual "pages" in magic instructions, as well as miscellaneous graphics.
* `menu/`
  * Various menu buttons/options that appear in the game.
* `minigamesplashes`
  * Minigame instructions that appear before starting a minigame, for adventure, challenge, and multiplayer mode. Also contains splash screens for entering a new world, as they use similar logic, as well as the title screen.
* `overworldtitles`
  * Level/World names that appear in the overworld.