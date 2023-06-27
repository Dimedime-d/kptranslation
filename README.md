This is my English translation project of the game Kururin Paradise. Check out the wiki and assorted assembly files in this repository for some documentation on the ROM.

## Extra Features
In addition to the translation aspect of this project, there is some additional functionality:
* You can re-watch Adventure Mode cutscenes in Practice Mode.

## Screenshots

![Newtitle](https://user-images.githubusercontent.com/73413313/249013413-b3a88ca7-2922-49fc-bc88-9af111db4c3e.png)
![Intro](https://user-images.githubusercontent.com/73413313/118182581-2e549d00-b407-11eb-9249-e57a80671997.png)![Overworld Map](https://user-images.githubusercontent.com/73413313/145687335-07e6ee2a-6e1e-445d-ad79-ef9399249cbb.png)

![Menu](https://user-images.githubusercontent.com/73413313/118183115-bdfa4b80-b407-11eb-81f4-b48ba8d6f463.png)
![Dialogue placeholder](https://user-images.githubusercontent.com/73413313/118183199-d4a0a280-b407-11eb-9c8c-97c9763dbac6.png)![InLevel](https://user-images.githubusercontent.com/73413313/145758653-84e19125-517c-466a-ac73-6962bdfc3aaa.png)

![KeyGet](https://user-images.githubusercontent.com/73413313/249255538-0c87b23d-1586-4ee4-b17d-c7962f135be7.png)
![Minigame menu](https://user-images.githubusercontent.com/73413313/118183148-c6528680-b407-11eb-8706-71e3966a8baa.png)![Minigame Splash](https://user-images.githubusercontent.com/73413313/145687348-8cca6643-1bc8-4d63-8a88-7d76131696d0.png)

![Menu](https://user-images.githubusercontent.com/73413313/249256101-db3d1cc3-6e8f-4e57-a003-8a5c84dd1b40.png)

## How to use

* Get a ROM of Kururin Paradise. Should match these hashes:

Method | Hash
------- | ------------------------------------------------------------
SHA256 | ED9BAC12FE065D11ADFFB08A27DE1A932E4E5A22CBF6B4B24FE28EF49F5385D2 
SHA-1 | 73BE3B930E2436D1C7BDB74AC281DD27C72E1F9E

* Rename rom to `kp.gba`
* Put kp.gba in the root of the repository
* Run `build.bat`
* Output ROM is `kp_patched.gba`

## Known Bugs

* The "Learn" option in the Magic menu displays glitchy text, due to me replacing the Japanese glyphs there.
* The butterfly in the intro doesn't animate correctly (See ![#3](https://github.com/Dimedime-d/kptranslation/issues/3))

## To-do List

* Put in translations for the rest of the dialogue (currently, much of it is lorem ipsum)
* Hack in the rest of the minigame splash screens
* Hack in translated magic descriptions + magic select screen graphics
* Optimize the space taken up by this translation (currently, I have the ROM expanded to 16 MB for no reason)

## License and contributions

Armips was created by Kingcom.
grit was created by cearn, Jasper Vijn
`armips.exe` and `graphics/grit.exe` are licensed under the MIT license.
The text box "You got the Key for this place!" was taken from a much buggier translation patch of this game, with some slight modifications.


All other files in this repository are licensed under the GNU General Public License v3 (GNU GPL-3)

The LanaPixel font was used to generate some text in some images (minigame instructions). LanaPixel was created by eishiya and is licensed under Creative Commons 4.0 International.

This software uses the FreeImage open source image library. See http://freeimage.sourceforge.net for details.

FreeImage is used under GNU GPL, version 3. 

See `LICENSE.MD` for license texts.
