This is a translation of the game Kururin Paradise. I moved this repo from a private one on Bitbucket. I'm cleaning up my code to make it more presentable for public users. I'm also working on a wiki, putting all my documentation there.

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


## Known Bugs

* Game softlocks upon entering any minigame (magic hat in overworld) when the text box loads, because I didn't put any text yet.

## To-do List

* Correct minigame names
* Put in translations for the rest of the dialogue
* Fork over my title screen/overworld title hacks from a private repository
* Remove dependency on Atlas, and manage all my text through armips to manage my space better
* Translate the end credits (and add credits pertaining to my translation work)
* Implement text welding (meshing different letter objects whose individual widths are small into the same object to save object slots) to show all the English text correctly in the magic description
* Optimize the space taken up by this translation (currently, I have the ROM expanded to 16 MB for no reason)

## Space Used

0x080B000 (0x8000)
	-Hook to contain custom code, including VWF (variable-width font) and challenge/minigame menu code
	
0x0880000 (??)
	-Space to contain English text

0x0883000 (0x10000)
	-Text/Menu Labels that do not fit in the original space

