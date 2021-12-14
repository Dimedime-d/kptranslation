# auto-generates a .asm file to import the menu buttons
# TODO: Also hack in the multiplayer menu buttons that are sent to other GBA's
import sys
import os
from PIL import Image
from dataclasses import dataclass

sys.path.append("..")
from compression import ByBlock, Block

TEMP_FOLDER = "reserve"
DUMP_FOLDER = "dumps"

palettes = { # Really just here to convert the .png's easier, in-game handles palettes separately...
    "highlighted yellow": [232, 112, 208, 168, 48, 168, 208, 144, 168, 248, 248, 176, 232, 192, 176, 216, 144, 176, 200, 96, 176, 184, 48, 184, 0, 0, 0, 0, 0, 0, 120, 120, 32, 248, 248, 64, 112, 248, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    "highlighted blue": [232, 112, 208, 72, 88, 200, 136, 168, 192, 208, 248, 184, 176, 208, 192, 152, 176, 200, 120, 144, 208, 96, 112, 216, 0, 0, 0, 40, 80, 192, 136, 144, 80, 248, 248, 64, 112, 248, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    "pink": [232, 112, 208, 224, 72, 144, 232, 136, 184, 248, 200, 224, 240, 168, 200, 232, 136, 184, 224, 104, 168, 216, 80, 152, 0, 0, 0, 0, 0, 0, 120, 120, 32, 248, 248, 64, 112, 248, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    "orange": [232, 112, 208, 248, 120, 0, 248, 184, 72, 248, 248, 144, 248, 208, 120, 248, 176, 96, 248, 144, 72, 248, 112, 48, 0, 0, 0, 176, 64, 0, 168, 144, 32, 248, 248, 64, 112, 248, 240, 0, 0, 0, 0, 0, 0, 0, 0, 0]
}

def quantize_to_palette(img, palette, dither=Image.NONE):
    palImage = Image.new("P", (1, 1))
    palImage.putpalette(palette + [0, 0, 0] * 240)
    return img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)

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
        converted_file = self.quantize_image_to_palette_and_save(self.img_file, self.palette)
        bin_file = os.path.join(DUMP_FOLDER, f"{self.img_file[:-4]}")
        # In order: No palette, 4bpp, tile format, NO MAP,
        # 4x2 metatiles, .bin file, no header, output file
        os.system(f"cmd /c ..\grit {converted_file} -p! -gB4 -gt -m! -Mw4 -Mh2 -ftb -fh! -o {bin_file}")
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
        
    @staticmethod
    def quantize_image_to_palette_and_save(img_file, palette):
        """Quantizes given image to palette, saves and returns path to converted image file"""
        img: Image.Image = Image.open(img_file)
        
        palImage = Image.new("P", (16, 16))
        palImage.putpalette(palette + [0,0,0]*240)
        converted_image = img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)
        converted_file = os.path.join(TEMP_FOLDER, f"{img_file[:-4]}-converted.png")
        converted_image.save(converted_file)
        return converted_file

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
]

def format_menu_buttons():
    for btn in menu_buttons:
        btn.format()

def main():
    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)
    
    format_menu_buttons()
    
    print("formatted all buttons. check the .asm files if you changed the picture names")
    
if __name__ == "__main__":
    main()