import sys
from dataclasses import dataclass
from PIL import Image
import os

sys.path.append("..")
from compression import LZ

TEMP_FOLDER = "reserve" # holds intermediate files
DUMP_FOLDER = "dumps" # contains binaries ready to be inserted
PARENT_FOLDERS = ["graphics", "minigamesplashes"]

# dumped directly from the ROM (from palette pointers in the minigame splash struct)
palettes = {
    "crossfire": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 64, 0, 24, 96, 16, 0, 64, 64, 96, 88, 104, 128, 72, 120, 168, 248, 72, 32, 128, 120, 152, 96, 136, 184, 0, 208, 248, 168, 184, 224, 112, 248, 240, 208, 208, 216, 248, 248, 64, 248, 248, 248, 8, 0, 0]
    },
    "star": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 56, 64, 168, 64, 80, 176, 64, 96, 216, 168, 88, 0, 0, 152, 192, 72, 112, 208, 80, 136, 216, 120, 120, 208, 80, 144, 208, 32, 200, 216, 224, 160, 16, 104, 248, 240, 248, 248, 88, 224, 248, 224, 0, 0, 0]
    },
    "bounce": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 72, 40, 0, 152, 96, 24, 56, 128, 104, 16, 160, 248, 24, 168, 248, 64, 184, 240, 248, 160, 0, 88, 192, 248, 136, 192, 144, 104, 208, 248, 136, 232, 248, 184, 232, 176, 248, 232, 24, 192, 248, 248, 0, 0, 0]
    },
    "dots": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 144, 0, 0, 0, 48, 112, 0, 96, 96, 248, 0, 0, 0, 120, 56, 96, 96, 88, 56, 104, 136, 112, 176, 192, 160, 160, 160, 248, 128, 128, 112, 248, 240, 248, 216, 192, 248, 248, 64, 192, 248, 248, 0, 0, 0]
    },
    "grass": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 8, 16, 64, 120, 96, 16, 72, 128, 8, 88, 144, 8, 136, 128, 88, 112, 160, 8, 152, 136, 72, 128, 176, 8, 160, 192, 16, 184, 176, 128, 176, 216, 40, 112, 248, 240, 224, 216, 160, 224, 232, 88, 0, 0, 0]
    },
    "ice": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 24, 64, 136, 40, 104, 176, 120, 120, 32, 72, 144, 208, 64, 160, 248, 248, 120, 0, 80, 176, 248, 128, 176, 216, 144, 208, 248, 112, 248, 240, 176, 224, 248, 248, 248, 48, 208, 248, 232, 248, 248, 248, 0, 0, 0]
    },
    "sky": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 0, 32, 56, 0, 80, 136, 128, 112, 0, 40, 152, 184, 0, 160, 232, 0, 176, 232, 0, 192, 240, 184, 184, 0, 240, 160, 8, 64, 208, 248, 112, 208, 248, 152, 224, 248, 248, 232, 88, 248, 240, 248, 0, 0, 0]
    },
    "fall": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 80, 0, 0, 72, 40, 0, 24, 88, 160, 0, 112, 248, 0, 136, 248, 0, 152, 248, 176, 104, 48, 16, 168, 248, 32, 184, 248, 216, 152, 72, 48, 208, 248, 248, 176, 120, 248, 224, 8, 248, 224, 192, 0, 0, 0]
    },
    "magnet": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 0, 48, 88, 0, 144, 160, 80, 120, 176, 8, 160, 184, 48, 144, 248, 128, 112, 248, 0, 184, 248, 0, 192, 224, 88, 152, 240, 128, 176, 232, 120, 200, 112, 192, 232, 248, 120, 232, 232, 176, 216, 128, 0, 0, 0]
    },
    "race": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 72, 0, 0, 32, 48, 48, 232, 0, 0, 16, 104, 0, 48, 128, 0, 64, 160, 0, 96, 176, 8, 176, 168, 176, 112, 208, 208, 184, 184, 184, 208, 200, 200, 112, 248, 240, 248, 232, 136, 248, 248, 248, 0, 0, 0]
    },
    "shoot": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 56, 128, 248, 0, 200, 72, 248, 88, 0, 112, 152, 152, 48, 168, 248, 0, 248, 184, 96, 192, 248, 64, 216, 248, 128, 200, 232, 96, 248, 200, 248, 184, 128, 144, 232, 248, 248, 248, 120, 248, 248, 248, 0, 0, 0]
    },
    "twin": {
        "text": [0, 0, 0, 72, 152, 184, 136, 200, 240, 0, 152, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 168, 168, 0, 248, 248, 0, 56, 64, 248, 200, 0, 248, 248, 248],
        "pic": [248, 0, 248, 0, 64, 96, 0, 104, 144, 0, 152, 192, 96, 192, 8, 192, 136, 40, 144, 192, 0, 248, 176, 0, 248, 184, 56, 248, 192, 32, 160, 232, 72, 104, 248, 240, 248, 216, 136, 248, 248, 64, 208, 248, 248, 0, 0, 0]
    },
}
DUMMY_COLOR = [248, 0, 248] # Pink color used in transparent tiles of picture image

asm_outfile = "minigamesplash.asm"
asm_header = """; This file was automatically generated by formatsplashes.py

.macro pad
    .word 0x00 :: .align
.endmacro

; minigame splash struct array at 0x2E6D4 (16 bytes each)
; 1st dword (4 bytes) - palette pointer
; 2nd dword - tileset pointer (compressed)
; 3rd dword - compressed tileset size
; 4th dword - tilemap pointer (compressed)

; 0x02E6D4 ~ 0x02E6F4 - 2 blank entries

; 0x02E6F4 - crossfire palette would be here

"""

@dataclass(slots=True)
class SplashScreen:
    text_img_file: str
    pic_img_file: str
    text_pal: list
    pic_pal: list
    armips_id: str
    tileset_label: str # unique armips_id in constructor generates two armips labels
    tileset_size: int # compressed tileset size
    tilemap_label: str
    tileset_dmp_file: str # to contain paths to the files with the merged and compressed tileset and tilemap
    tilemap_dmp_file: str
    offset: str # really an int but just goes into the generated asm file
    
    def __init__(self, text_img, pic_img, palette_key, armips_id, offset):
        self.text_img_file = text_img
        self.pic_img_file = pic_img
        self.text_pal = palettes[palette_key]["text"]
        self.pic_pal  = palettes[palette_key]["pic"]
        self.armips_id = armips_id
        self.tileset_label = f"{armips_id}Tiles"
        self.tilemap_label = f"{armips_id}Map"
        self.offset = offset
        self.tileset_size = -1 # to be modified
        self.tileset_dmp_file = os.path.join(DUMP_FOLDER, f"{self.tileset_label}.dmp")
        self.tilemap_dmp_file = os.path.join(DUMP_FOLDER, f"{self.tilemap_label}.dmp")

    def get_repoint_asm(self):
        """Helper method to auto-generate part of the armips script that repoints to new splash screen data"""
        return \
f""".org {self.offset}
    .word @{self.tileset_label}
    .word 0x{self.tileset_size:X}
    .word @{self.tilemap_label}
"""

    def get_incbin_asm(self):
        """Helper method to auto-generate part of the armips script that includes the compressed tileset and tilemap
        (Note: these .incbins are expected to be inside an autoregion)"""
        return \
f'''    @{self.tileset_label}:
    .incbin "{os.path.join(*PARENT_FOLDERS, self.tileset_dmp_file)}" :: pad
    @{self.tilemap_label}:
    .incbin "{os.path.join(*PARENT_FOLDERS, self.tilemap_dmp_file)}" :: pad
'''

splash_screens = [
    SplashScreen("crossfire-text.png",  "crossfire-pic.png",    "crossfire",    "crossfire",    "0x0802E6F8"),
    SplashScreen("star-text.png",       "star-pic.png",         "star",         "star",         "0x0802E708"),
    SplashScreen("bounce-text.png",     "bounce-pic.png",       "bounce",       "bounce",       "0x0802E718"),
    
    SplashScreen("dots-text.png",       "dots-pic.png",         "dots",         "dots",         "0x0802E738"),
    SplashScreen("grass-text.png",      "grass-pic.png",        "grass",        "grass",        "0x0802E748"),
    SplashScreen("ice-text.png",        "ice-pic.png",          "ice",          "ice",          "0x0802E758"),
    SplashScreen("sky-text.png",        "sky-pic.png",          "sky",          "sky",          "0x0802E768"),
    
    
    SplashScreen("fall-text.png",       "fall-pic.png",         "fall",         "fall",         "0x0802E798"),
    SplashScreen("magnet-text.png",     "magnet-pic.png",       "magnet",       "magnet",       "0x0802E7A8"),
    SplashScreen("race-text.png",       "race-pic.png",         "race",         "race",         "0x0802E7B8"),
    SplashScreen("shoot-text.png",      "shoot-pic.png",        "shoot",        "shoot",        "0x0802E7C8"),
    SplashScreen("twin-text.png",       "twin-pic.png",         "twin",         "twin",         "0x0802E7D8"),
]

#https://stackoverflow.com/a/237193
def quantize_to_palette(img, palette, dither=Image.NONE):
    palImage = Image.new("P", (16, 16))
    palImage.putpalette(palette)
    return img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)

def format_images(splash: SplashScreen):
    """Goal is to put my English .png minigame splashes in this folder, and then spit out .dmp files ready to be inserted into the ROM (no GUI needed!)"""
    
    text_tiles, text_map, pic_tiles, pic_map = ["" for i in range(4)]
    # First, generate uncompressed tilesets and tilemaps for the text and picture
    pic_tilemap_offset = 0
    for i, (file, pal) in enumerate(zip((splash.text_img_file, splash.pic_img_file), (splash.text_pal, splash.pic_pal))):
        try:
            image: Image.Image = Image.open(file)
            assert image.width == 240 and image.height == 160,  f"{file} does not match dimensions of a GBA screen (240x160) - different size images are not supported"
            
            palette = []
            if i == 0:
                palette = pal + [0, 0, 0]*240
            elif i == 1: # Picture uses background palette 1
                palette = DUMMY_COLOR*16 + pal + DUMMY_COLOR*224

            # Quantize image to palette and save it (save is necessary for grit to access it)
            image = quantize_to_palette(image, palette)
            converted_file = os.path.join(TEMP_FOLDER, f"{file[:-4]}-converted.png")
            image.save(converted_file)
            
            # In order: No palette, 4bpp, tile format, reg flat map layout, reduce tiles+pal+flip, dynamic tilemap offset,
            # metatile reduction, 1x1 metatiles, .bin file, no header, output file
            os.system(f"cmd /c grit {converted_file} -p! -gB4 -gt -mLf -mRtpf -ma{pic_tilemap_offset} -MRp -Mh1 -Mw1 -ftb -fh! -o {converted_file[:-4]}.bin")
            tileset_file = f"{converted_file[:-4]}.img.bin"
            tilemap_file = f"{converted_file[:-4]}.map.bin"
            if i == 0:
                # Important that the picture data uses this offset to reference its tiles correctly when the tileset and tilemap get merged
                pic_tilemap_offset = os.path.getsize(tileset_file) // 0x20 - 1
                text_tiles = tileset_file
                text_map = tilemap_file
            elif i == 1:
                pic_tiles = tileset_file
                pic_map = tilemap_file
        except FileNotFoundError:
            print(f"{file} not found.")
    
    # Really not necessary, but it's good to check the merged and uncompressed tileset and tilemap...
    merged_uncompressed_tileset_file = os.path.join(TEMP_FOLDER, f"{splash.tileset_label}Uncomp.bin")
    merged_uncompressed_tilemap_file = os.path.join(TEMP_FOLDER, f"{splash.tilemap_label}Uncomp.bin")
    
    # Then, merge the uncompressed tilesets and tilemaps into one
    uncomp_tiles, uncomp_map = merge_binaries(text_tiles, text_map, pic_tiles, pic_map, tiles_out=merged_uncompressed_tileset_file, map_out=merged_uncompressed_tilemap_file, sideways=splash.armips_id == "fall")
    
    # Performance bottleneck is here, unsurprisingly. 
    comp_tiles, comp_map = LZ.compress(uncomp_tiles), LZ.compress(uncomp_map)
    
    # Finally, output the compressed .dmp files, and assign tileset size variable
    with open(splash.tileset_dmp_file, "wb") as tileset_file, open(splash.tilemap_dmp_file, "wb") as tilemap_file:
        tileset_file.write(comp_tiles)
        tilemap_file.write(comp_map)
        print(f"wrote {tileset_file.name} and {tilemap_file.name}")
        
    splash.tileset_size = len(comp_tiles)
    
def merge_binaries(text_tiles, text_map, pic_tiles, pic_map, tiles_out=None, map_out=None, sideways=False):

    # Merge tilesets
    tile_bytes = None
    with open(text_tiles, "rb") as txt, open(pic_tiles, "rb") as pic:
        tile_bytes = bytearray(txt.read())
        pic_tile_bytes  = bytearray(pic.read())
        tile_bytes += pic_tile_bytes[32:] # Skip 1st tile in picture tileset (the transparent tile)
    
    if tiles_out is not None:
        with open(tiles_out, "wb") as file:
            file.write(tile_bytes)

    map_bytes = None
    def bytecount(x, y):
        return 60*x + 2*y

    # Merge maps
    with open(text_map, "rb") as txt, open(pic_map, "rb") as pic:
        map_bytes = bytearray(txt.read())
        pic_map_bytes = bytearray(pic.read())
        ulx, uly = 2, 4
        if sideways:
            ulx, uly = 17, 2
        for i in range(uly, uly+8, 1):
            map_bytes[bytecount(i, ulx):bytecount(i, ulx+8)] = pic_map_bytes[bytecount(i, ulx):bytecount(i, ulx+8)]
    
    if map_out is not None:
        with open(map_out, "wb") as file:
            file.write(map_bytes)
    
    return tile_bytes, map_bytes

def main():
    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)

    repoint_strs = []
    incbin_strs  = []
    
    for splash in splash_screens:
        format_images(splash)
        repoint_strs.append(splash.get_repoint_asm())
        incbin_strs.append(splash.get_incbin_asm())
    
    # Add comments if in between if need be
    
    with open(asm_outfile, "w") as file:
        file.write(asm_header)
        file.write("\n".join(repoint_strs))
        file.write("\n.autoregion\n    .align\n")
        file.write("\n".join(incbin_strs))
        file.write(".endautoregion")
    
    print(f"wrote {asm_outfile}")
    
if __name__ == "__main__":
    main()