This is a translation of the game Kururin Paradise. I moved this repo from a private one on Bitbucket. I'm cleaning up my code to make it more presentable for public users. I'm also working on a wiki, putting all my documentation there.

## Screenshots

![Intro](https://user-images.githubusercontent.com/73413313/118182581-2e549d00-b407-11eb-9249-e57a80671997.png)![Dialogue placeholder](https://user-images.githubusercontent.com/73413313/118183199-d4a0a280-b407-11eb-9c8c-97c9763dbac6.png)![Overworld Map](https://user-images.githubusercontent.com/73413313/145687335-07e6ee2a-6e1e-445d-ad79-ef9399249cbb.png)


![Minigame menu](https://user-images.githubusercontent.com/73413313/118183148-c6528680-b407-11eb-8706-71e3966a8baa.png)![Menu](https://user-images.githubusercontent.com/73413313/118183115-bdfa4b80-b407-11eb-81f4-b48ba8d6f463.png)![Minigame Splash](https://user-images.githubusercontent.com/73413313/145687348-8cca6643-1bc8-4d63-8a88-7d76131696d0.png)


## How to use

* Get a ROM of Kururin Paradise. Should match these hashes:

Method | Hash
------- | ------------------------------------------------------------
SHA256 | ED9BAC12FE065D11ADFFB08A27DE1A932E4E5A22CBF6B4B24FE28EF49F5385D2 
SHA-1 | 73BE3B930E2436D1C7BDB74AC281DD27C72E1F9E

* Rename rom to "kp.gba"
* Put kp.gba in the root of the repository
* Run "build.bat"
* Output ROM is "kp_patched.gba"


## To-do List

* Correct minigame names
* Put in translations for the rest of the dialogue (currently, much of it is lorem ipsum)
* Fork over my title screen/overworld title hacks from a private repository
* Hack in translated magic descriptions
* Refactor the way I generate my graphical binary data to make minor edits less tedious
* Optimize the space taken up by this translation (currently, I have the ROM expanded to 16 MB for no reason)

## Space Used

0x080B0000 (0x8000)
	-Hook to contain custom code, including VWF (variable-width font) and challenge/minigame menu code

0x08800000 (0x800000) (Autoregion)
	-ASCII strings and cutscene scripts that don't fit in the original space

I have an additional autoregion at the original intro cutscene location `0xA77C8`

## License and contributions

Armips was created by Kingcom.
grit was created by cearn, Jasper Vijn
`armips.exe` and `graphics/grit.exe` are licensed under the MIT license.


All other files in this repository are licensed under the GNU General Public License v3 (GNU GPL-3)

The LanaPixel font was used to generate some text in some images (minigame instructions). LanaPixel was created by eishiya and is licensed under Creative Commons 4.0 International.

This software uses the FreeImage open source image library. See http://freeimage.sourceforge.net for details.

FreeImage is used under GNU GPL, version 3. 

See `LICENSE.MD` for license texts.
