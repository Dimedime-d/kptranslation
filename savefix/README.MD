This utility is only meant to be used if you started a playthrough on the Japanese ROM and want to fix the default Japanese names as they appear in the Top 3 records of each course or minigame.

If this is your first time playing _Kururin Paradise_, this utility does not apply to you.

# Instructions

* Download `SaveFix.exe` from the latest release OR compile the included Haskell script.
* Get your _Kururin Paradise_ SRAM file ready. It **must** be uncompressed/raw. It should be 64/128 KB, and the first few hex characters should read `KURUPARA` in ASCII.
* Drag and drop your save file onto `SaveFix.exe` OR use the command prompt to call the .exe with the save file as the only argument.
* The output fixed save file will be `<filename>-fixed.<extension>`.
* Backup your original save file, just in case.
* Overwrite your original save file as it is read into the emulator by re-naming the fixed save file to match the original.
