# Goal - generate a 0x1000 byte size binary file containing lowercase ascii and the bubble numbers, then compress it.
# It should fit inside the payload space for Minigame Paradise, when the client decompresses this binary.
import sys
import os

sys.path.append("../graphics/")
from compression import LZ

def main():
    with open("mpObjTiles.bin", "wb") as outfile:
        outfile.write(b"\x00" * 0x20)
        with open("lowercaseascii.bin", "rb") as file1:
            outfile.write(file1.read())
        outfile.write(b"\x00" * (0x780 - outfile.tell()))
        with open("../graphics/menu/dumps/bubblenums.img.bin", "rb") as file2:
            outfile.write(file2.read())
        assert outfile.tell() == 0x1000, "wrong file size"
    
    with open("mpObjTiles.bin", "rb") as binfile:
        comp_data = LZ.compress(binfile.read())
    with open("mpObjTilesComp.bin", "wb") as finalfile:
        finalfile.write(comp_data)
    os.remove("mpObjTiles.bin")
    
if __name__ == "__main__":
    main()