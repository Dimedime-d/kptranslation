This is my English translation project of the game Kururin Paradise. Check out the wiki and assorted assembly files in this repository for some documentation on the ROM.

Much of the existing translations are just placeholders, and demonstrate that I can inject arbitrary English text/graphics.

## Extra Features

In addition to the translation aspect of this project, there is some additional functionality:
* You can re-watch Adventure Mode cutscenes in Practice Mode.
* The functionality for deleting all save data / reinitializing corrupted save data has been restored. In the original ROM, if you held A, B, L, R, Start, and Select before the Nintendo logo appears, the game would crash. Same thing happens when the SRAM checksum fails. This is due to the game trying to create a buffer in a space that hasn't been initialized yet. This may matter for flashcart testing...

## Manual Patching (Windows only)

* Clone this repository
* Get a ROM of Kururin Paradise. Should match these hashes:

Method | Hash
------- | ------------------------------------------------------------
SHA256 | ED9BAC12FE065D11ADFFB08A27DE1A932E4E5A22CBF6B4B24FE28EF49F5385D2 
SHA-1 | 73BE3B930E2436D1C7BDB74AC281DD27C72E1F9E

* Rename rom to `kp.gba`
* Put kp.gba in the root of the repository
* Run `build.bat`
* Output ROM is `kp_patched.gba`

## Debug Features

You change the value of `DEBUG_VAR` in `build.bat` to a nonzero number to enable one debugging feature. Currently, you can re-watch the "rank up" cutscenes and re-view the location splash screens by holding L after any "level complete" screen.

## Patching Notes

My "patching" program of choice is `armips`, which lets me write assembly hacks, include binaries, dynamically address labels, etc. Some chunks of the ROM are compressed via the GBA's BIOS method, so the batch script also runs `lzss` by CUE to decompress those binaries (mainly multiplayer). `armips` hacks those binaries, and `lzss` re-compresses them to be inserted into the ROM by invoking `armips` again. The whole patching process is self-contained, aside from the ROM.

The "encoded" text in the ROM is automatically patched using the above batch script i.e. you can change the contents of the text in the `text/` folder, and they will appear in the ROM when you manually patch.

All "graphical" text in the ROM is _not_ automatically formatted and inserted. Should you change the images, there are a smattering of Python scripts in the `graphics/` folders to format the images to `.dmp` files, which has already been done. Python is my fast and dirty way of re-quantizing images to the same palettes used in game, compressing data using the game's custom functions as well as operating `grit.exe`. You do not need Python to patch the ROM, only to format new images if you choose to do so.

## Known Bugs

* Some character animations play faster than usual, due to my timing of the "rolling" text characters being faster.
* Transferring save data from the original Japanese ROM will result in slightly glitched in-game names, as the Japanese names remain in SRAM. Same thing will probably also happen if you named one of the save files with Japanese characters. I'm okay with this, as this doesn't impact the first-time experience.

## ~~To-do List~~ Further Improvements

I'm basically done with this patch. If I could make it better, here would be some places of revision:

* The game scripts (especially the dialogue) can always be improved
* Optimize the credits sequence to display more text at once (currently limited by GBA OAM slots)
* Optimize the space taken up by this translation (currently, I have the ROM expanded to 16 MB for no reason)

## Other Language Support

There don't appear to be glyphs of extended Latin characters in the ROM, nether in the "ASCII" font nor in the font used in dialogue. Also, I had enough trouble getting lowercase ASCII characters to load properly in some places, as they weren't loaded by default. Should anyone decide to translate into other Romance languages, you would have to implement your own glyphs and load them properly.

## Screenshots

![Newtitle](https://user-images.githubusercontent.com/73413313/249013413-b3a88ca7-2922-49fc-bc88-9af111db4c3e.png)
![Intro](https://user-images.githubusercontent.com/73413313/118182581-2e549d00-b407-11eb-9249-e57a80671997.png)![Overworld Map](https://user-images.githubusercontent.com/73413313/145687335-07e6ee2a-6e1e-445d-ad79-ef9399249cbb.png)

![newpractice](https://github.com/Dimedime-d/kptranslation/assets/73413313/c2728a86-7247-4549-bf1a-c0def0d0ddf0)
![dialog](https://github.com/Dimedime-d/kptranslation/assets/73413313/c9aedc5f-0458-4db8-94c1-ff16f206b9a8)
![InLevel](https://user-images.githubusercontent.com/73413313/145758653-84e19125-517c-466a-ac73-6962bdfc3aaa.png)

![KeyGet](https://user-images.githubusercontent.com/73413313/249255538-0c87b23d-1586-4ee4-b17d-c7962f135be7.png)
![Minigame menu](https://user-images.githubusercontent.com/73413313/118183148-c6528680-b407-11eb-8706-71e3966a8baa.png)![Minigame Splash](https://user-images.githubusercontent.com/73413313/145687348-8cca6643-1bc8-4d63-8a88-7d76131696d0.png)

![Menu](https://user-images.githubusercontent.com/73413313/249256101-db3d1cc3-6e8f-4e57-a003-8a5c84dd1b40.png)
![magiceng](https://github.com/Dimedime-d/kptranslation/assets/73413313/33085c03-aedf-45f0-b1cc-d96b272f0bd1)
![magiceng2](https://github.com/Dimedime-d/kptranslation/assets/73413313/792843a8-1fea-40dd-829c-baa4bfd1c238)

## License and contributions

Special thanks to **E-Sh4rk** for documenting one of the compression/decompression routines the game uses.

Special thanks to **NewGBAXL** for revising the main game scripts (dialogue)

Armips was created by Kingcom.

grit was created by cearn, Jasper Vijn

`armips.exe` and `graphics/grit.exe` are licensed under the MIT license.

`lzss.exe` is by CUE and licensed under GNU GPL, version 3.

The text box "You got the Key for this place!" was taken from a much buggier translation patch of this game, with some slight modifications.

All other files in this repository are licensed under the GNU General Public License v3 (GNU GPL-3)

The LanaPixel font was used to generate some text in some images (minigame instructions). LanaPixel was created by eishiya and is licensed under Creative Commons 4.0 International.

This software uses the FreeImage open source image library. See http://freeimage.sourceforge.net for details.

FreeImage is used under GNU GPL, version 3. 

See `LICENSE.MD` for license texts.
