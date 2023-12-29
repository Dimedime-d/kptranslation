# Kururin Paradise Translation

Ready to fly? Explore many worlds in this sequel to Kuru Kuru Kururin, piloting the Helirin with its ever-rotating propeller. In this adventure, your family went missing when they went to see a magic show. It's up to you to search for them and bring them back home. Overcome new challenges using the right shoulder button to speed up the Helirin's rotation. Between all the Helirin mazes, you will encounter the people behind the magic show and be challenged to a variety of minigames. They probably have something to do with your family, and you might even learn a magic trick or two along the way.

## Patching

* Original ROM: `Kururin Paradise (J).gba`
* SHA-1 Hash: `73BE3B930E2436D1C7BDB74AC281DD27C72E1F9E`

__bps patch (Recommended)__

* Download [Floating IPS](https://www.romhacking.net/utilities/1040/)
* Download [the latest release](https://github.com/Dimedime-d/kptranslation/releases/latest/)
* Open Floating IPS and patch the original ROM with the bps patch.

__Manual Patch (Windows only)__

* Clone this repository
* Rename your dumped ROM to `kp.gba`
* Put kp.gba in the root of the repository
* Run `build.bat`
* Output ROM is `kp_patched.gba`

## Extra Features

In addition to the translation aspect of this project, there is some additional functionality on top of the base game:
* You can re-watch Adventure Mode cutscenes in Practice Mode.
* The functionality for deleting all save data / reinitializing corrupted save data has been restored. In the original ROM, if you held A, B, L, R, Start, and Select before the Nintendo logo appears, the game would crash. Same thing happens when the SRAM checksum fails. This is due to the game trying to create a buffer in a space that hasn't been initialized yet. This may matter for flashcart testing...

## Debug Features

You change the value of `DEBUG_VAR` in `build.bat` to a nonzero number to enable one debugging feature. Currently, you can re-watch the "rank up" cutscenes and re-view the location splash screens by holding L after any "level complete" screen.

## Screenshots

![Newtitle](https://user-images.githubusercontent.com/73413313/249013413-b3a88ca7-2922-49fc-bc88-9af111db4c3e.png)
![Intro](https://user-images.githubusercontent.com/73413313/118182581-2e549d00-b407-11eb-9249-e57a80671997.png)
![overworld1](https://github.com/Dimedime-d/kptranslation/assets/73413313/efca7050-6a9e-45a8-a4b0-c50be96f043b)

![newpractice](https://github.com/Dimedime-d/kptranslation/assets/73413313/c2728a86-7247-4549-bf1a-c0def0d0ddf0)
![dialog](https://github.com/Dimedime-d/kptranslation/assets/73413313/c9aedc5f-0458-4db8-94c1-ff16f206b9a8)
![InLevel](https://user-images.githubusercontent.com/73413313/145758653-84e19125-517c-466a-ac73-6962bdfc3aaa.png)

![KeyGet](https://user-images.githubusercontent.com/73413313/249255538-0c87b23d-1586-4ee4-b17d-c7962f135be7.png)
![Minigame menu](https://user-images.githubusercontent.com/73413313/118183148-c6528680-b407-11eb-8706-71e3966a8baa.png)![Minigame Splash](https://user-images.githubusercontent.com/73413313/145687348-8cca6643-1bc8-4d63-8a88-7d76131696d0.png)

![Menu](https://user-images.githubusercontent.com/73413313/249256101-db3d1cc3-6e8f-4e57-a003-8a5c84dd1b40.png)
![magicdemo](https://github.com/Dimedime-d/kptranslation/assets/73413313/7967a269-ad59-4107-b8c5-06f8f2ebc1ff)
![magiceng2](https://github.com/Dimedime-d/kptranslation/assets/73413313/792843a8-1fea-40dd-829c-baa4bfd1c238)

## Patching Notes

My "patching" program of choice is `armips`, which lets me write assembly hacks, include binaries, dynamically address labels, etc. Some chunks of the ROM are compressed via the GBA's BIOS method, so the batch script also runs `lzss` by CUE to decompress those binaries (mainly multiplayer). `armips` hacks those binaries, and `lzss` re-compresses them to be inserted into the ROM by invoking `armips` again. The whole patching process is self-contained, aside from the ROM.

The "encoded" text in the ROM is automatically patched using the above batch script i.e. you can change the contents of the text in the `text/` folder, and they will appear in the ROM when you manually patch.

All "graphical" text in the ROM is _not_ automatically formatted and inserted. Should you change the images, there are a smattering of Python scripts in the `graphics/` folders to format the images to `.dmp` files, which has already been done. Python is my fast and dirty way of re-quantizing images to the same palettes used in game, compressing data using the game's custom functions as well as operating `grit.exe`. You do not need Python to patch the ROM, only to format new images if you choose to do so.

## Known Bugs

* Some character animations play faster than usual, due to my timing of the "rolling" text characters being faster.
* Transferring save data from the original Japanese ROM will result in slightly glitched in-game names, as the Japanese names remain in SRAM. Same thing will probably also happen if you named one of the save files with Japanese characters. I'm okay with this, as this doesn't impact the first-time experience.

## Areas of Potential Revision

* The game scripts (especially the dialogue)
* General graphical polish
* Optimize the credits sequence to display more text at once (currently limited by GBA OAM slots)

## Other Language Support

There don't appear to be glyphs of extended Latin characters in the ROM, nether in the "ASCII" font nor in the font used in dialogue. Also, I had enough trouble getting lowercase ASCII characters to load properly in some places, as they weren't loaded by default. Should anyone decide to translate into other Romance languages, you would have to implement your own glyphs and load them properly.

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
