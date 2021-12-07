Contains the raw graphics I made to insert into the ROM.

My original process for inserting graphics was to make my `.png` files, manually partition them into the proper tile dimensions (16x16, 32x16, etc.), then insert them into a dummy ROM using GBA graphics editor, then export the binary graphical data and palette (these are the `.bin` files found in this repo), and insert and repoint to the new graphical data in my armips scripts.

With my newfound Python knowledge, I should be able to go directly from my `.png` file to a `.dmp` file that uses the original palette. Saves a lot of clicks in theory, and making small edits to the `.png`'s doesn't take too much work anymore. Check out the Python scripts inside to see how I format them.