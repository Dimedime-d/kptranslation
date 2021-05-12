This folder contains armips files that insert binaries that are interpreted by the game's internal scripting engine.

I need to use armips commands to insert the necessary bytes because some of them are interpreted as pointers that re-route script execution. This makes it so that I can insert these binaries in any free space.

For text editing, I am hard-coding the commands that draw text to the screen. So, you should only have to edit the strings in `text/dialogue.asm` to change the dialogue.

