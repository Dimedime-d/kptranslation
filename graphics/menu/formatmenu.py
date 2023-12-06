# auto-generates a binaries of various menu buttons
# (some of these .dmp files are re-used in payloads for Single Pak Multiplayer)
import sys
import os
from PIL import Image
from dataclasses import dataclass

sys.path.append("..")
from compression import LZ, ByBlock, Block

TEMP_FOLDER = "reserve"
DUMP_FOLDER = "dumps"

palettes = { # Really just here to convert the .png's easier, in-game handles palettes separately...
    "highlighted yellow": [232, 112, 208, 168, 48, 168, 208, 144, 168, 248, 248, 176, 232, 192, 176, 216, 144, 176, 200, 96, 176, 184, 48, 184, 0, 0, 0, 0, 0, 0, 120, 120, 32, 248, 248, 64, 112, 248, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    "highlighted blue": [232, 112, 208, 72, 88, 200, 136, 168, 192, 208, 248, 184, 176, 208, 192, 152, 176, 200, 120, 144, 208, 96, 112, 216, 0, 0, 0, 40, 80, 192, 136, 144, 80, 248, 248, 64, 112, 248, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    "pink": [232, 112, 208, 224, 72, 144, 232, 136, 184, 248, 200, 224, 240, 168, 200, 232, 136, 184, 224, 104, 168, 216, 80, 152, 0, 0, 0, 0, 0, 0, 120, 120, 32, 248, 248, 64, 112, 248, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    "orange": [232, 112, 208, 248, 120, 0, 248, 184, 72, 248, 248, 144, 248, 208, 120, 248, 176, 96, 248, 144, 72, 248, 112, 48, 0, 0, 0, 176, 64, 0, 168, 144, 32, 248, 248, 64, 112, 248, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    "challenge highlighted": [0, 128, 152, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 56, 104, 80, 16, 168, 64, 152, 176, 96, 200, 208, 136, 248, 248], #0x1BBB60, decompressed, palette 10
    "ascii": [32, 152, 160, 0, 0, 0, 32, 152, 160, 240, 152, 152, 0, 64, 144, 0, 96, 160, 0, 128, 184, 184, 72, 0, 200, 128, 16, 224, 184, 40, 248, 248, 64, 0, 0, 0, 56, 56, 56, 120, 120, 120, 184, 184, 184, 248, 248, 248], #in a bunch of places
    "multiplayer results": [16, 136, 0, 136, 0, 0, 248, 0, 0, 248, 56, 0, 248, 120, 152, 176, 176, 184, 88, 40, 0, 208, 192, 184, 0, 0, 0, 0, 0, 0, 232, 224, 208, 192, 176, 176, 208, 192, 192, 232, 216, 208, 232, 224, 224, 248, 248, 248], #0x1355D4+5*0x20
}

def quantize_image_to_palette_and_save(img_file, palette):
        """Quantizes given image to palette, saves and returns path to converted image file"""
        img: Image.Image = Image.open(img_file)
        
        palImage = Image.new("P", (16, 16))
        palImage.putpalette(palette + [0,0,0]*240)
        converted_image = img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)
        converted_file = os.path.join(TEMP_FOLDER, f"{img_file[:-4]}-converted.png")
        converted_image.save(converted_file)
        return converted_file

@dataclass(slots=True)
class MenuButton:
    img_file: str
    palette: list
    compressed: bool
    dmp_file: str
    
    def __init__(self, img_file, palette, compressed=False):
        self.img_file = img_file
        self.palette = palettes.get(palette, [0, 0, 0]*16)
        self.compressed = compressed
    
    def format(self):
        # Take img file, convert it, grit it, get ref to dmp file
        converted_file = quantize_image_to_palette_and_save(self.img_file, self.palette)
        bin_file = os.path.join(DUMP_FOLDER, f"{self.img_file[:-4]}")
        # In order: No palette, 4bpp, tile format, NO MAP,
        # 4x2 metatiles, .bin file, no header, output file
        os.system(f"cmd /c ..\\grit {converted_file} -p! -gB4 -gt -m! -Mw4 -Mh2 -ftb -fh! -o {bin_file}")
        self.dmp_file = f"{bin_file}.dmp"
        if not self.compressed:
            if os.path.exists(self.dmp_file):
                os.remove(self.dmp_file)
            os.rename(f"{bin_file}.img.bin", self.dmp_file)
        else:
            comp_data = None
            with open(f"{bin_file}.img.bin", "rb") as file:
                comp_data = ByBlock.compress(file.read())
            with open(self.dmp_file, "wb") as file:
                file.write(comp_data)
            os.remove(f"{bin_file}.img.bin")
        print(f"wrote {self.dmp_file}")

menu_buttons = [
    MenuButton("1PAdventure.png", "highlighted yellow"),
    MenuButton("1PChallenge.png", "highlighted yellow"),
    MenuButton("1PPractice.png", "highlighted yellow"),
    MenuButton("1PMagic.png", "highlighted yellow"),
    MenuButton("1PKurukuruKururin.png", "highlighted blue"),
    MenuButton("1PMinigameParadise.png", "highlighted blue"),
    MenuButton("1PSinglePakVersus.png", "pink", True),
    MenuButton("1P2PKurukuruKururin.png", "highlighted blue", True),
    MenuButton("1P2PMinigameParadise.png", "highlighted blue", True),
    MenuButton("1P3PKurukuruKururin.png", "highlighted blue", True),
    MenuButton("1P3PMinigameParadise.png", "highlighted blue", True),
    MenuButton("1P4PKurukuruKururin.png", "highlighted blue", True),
    MenuButton("1P4PMinigameParadise.png", "highlighted blue", True),
    MenuButton("MultiFreePlay.png", "highlighted yellow", True),
    MenuButton("MultiRoundLimit.png", "highlighted yellow", True),
    MenuButton("MultiTimeLimit.png", "highlighted yellow", True),
]

def format_menu_buttons():
    for btn in menu_buttons:
        btn.format()

def format_other_text():
    # Case by case basis for some others that don't fit nicely into menu buttons...

    # Bubble numbers
    img_file = "bubblenums.png"
    converted_file = quantize_image_to_palette_and_save(img_file, palettes["challenge highlighted"])
    bin_file = os.path.join(DUMP_FOLDER, f"{img_file[:-4]}")
    # In order: No palette, 4bpp, tile format, NO MAP,
    # 2x2 metatiles, .bin file, no header, output file
    os.system(f"cmd /c ..\\grit {converted_file} -p! -gB4 -gt -m! -Mw2 -Mh2 -ftb -fh! -o {bin_file}")
    dmp_file = f"{bin_file}.dmp"
    comp_data = None
    with open(f"{bin_file}.img.bin", "rb") as file:
        comp_data = LZ.compress(file.read())
    with open(dmp_file, "wb") as file:
        file.write(comp_data)
    #os.remove(f"{bin_file}.img.bin")
    print(f"wrote {dmp_file}")
    
    # Random Text in challenge menu
    img_file = "random.png"
    converted_file = quantize_image_to_palette_and_save(img_file, palettes["challenge highlighted"])
    bin_file = os.path.join(TEMP_FOLDER, f"{img_file[:-4]}")
    os.system(f"cmd /c ..\\grit {converted_file} -p! -gB4 -gt -m! -Mw4 -Mh2 -aw32 -ftb -fh! -o {bin_file}1")
    os.system(f"cmd /c ..\\grit {converted_file} -p! -gB4 -gt -m! -Mw2 -Mh2 -al32 -ftb -fh! -o {bin_file}2")
    dmp_file = os.path.join(DUMP_FOLDER, f"{img_file[:-4]}.dmp")
    with open(f"{bin_file}1.img.bin", "rb") as bin1, open(f"{bin_file}2.img.bin", "rb") as bin2, open(dmp_file, "wb") as dmp:
        dmp.write(bin1.read())
        dmp.write(bin2.read())
    print(f"wrote {dmp_file}")
    
def format_minigame_titles():
    img_file = "minigametitles.png"
    converted_file = quantize_image_to_palette_and_save(img_file, palettes["ascii"])
    bin_file = os.path.join(DUMP_FOLDER, f"{img_file[:-4]}")
    # In order: No palette, 4bpp, tile format, NO MAP,
    # 4x1 metatiles, .bin file, no header, output file
    os.system(f"cmd /c ..\\grit {converted_file} -p! -gB4 -gt -m! -Mw4 -Mh1 -ftb -fh! -o {bin_file}")
    dmp_file = f"{bin_file}.dmp"
    if os.path.exists(dmp_file):
        os.remove(dmp_file)
    os.rename(f"{bin_file}.img.bin", dmp_file)
    print(f"wrote {dmp_file}")
    
def main():
    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)
    
    format_menu_buttons()
    format_other_text()
    format_minigame_titles()
    
    print("formatted all images in this folder. check the .asm files if you changed the picture names")
    
if __name__ == "__main__":
    main()