# Formats BIOS compressed tilesets/maps relating to magic tricks (typically within the magic tricks themselves)
# formatother.py was getting too crowded

from PIL import Image
from shutil import copyfile
import os
import struct
import sys

TEMP_FOLDER = "reserve"
DUMP_FOLDER = "dumps"
TRICK_FOLDER = "tricks"

def format_ten_and_hundred():
    pal = [248, 0, 0, 248, 248, 248, 0, 0, 0] + [160, 160, 160]*253 # dummy colors
    converted_intro_png = quantize_image_to_palette_and_save(os.path.join(TRICK_FOLDER, "tenhundredintro.png"), pal, "tenhundredintro-converted.png")
    converted_coin_png = quantize_image_to_palette_and_save(os.path.join(TRICK_FOLDER, "tenhundredcoin.png"), pal, "tenhundredcoin-converted.png")
    
    # Grit 'em
    # In order: No palette, 4bpp, tile format, force palette bank 0, reg flat map layout, reduce tiles+pal+flip,
    # metatile reduction, 1x1 metatiles, .bin file, no header
    intro_tiles_bin, intro_map_bin = grit_image(converted_intro_png, "-p! -gB4 -gt -mp0 -mLf -mRtpf -MRp -Mh1 -Mw1 -ftb -fh!")
    
    tilemap_offset = os.path.getsize(intro_tiles_bin) // 0x20
    
    coin_tiles_bin, coin_map_bin = grit_image(converted_coin_png, f"-p! -gB4 -gt -mp0 -mLf -mRtpf -ma{tilemap_offset} -MRp -Mh1 -Mw1 -ftb -fh!")
    
    # Merge ONLY the tilesets
    tile_bytes = None
    with open(intro_tiles_bin, "rb") as intro, open(coin_tiles_bin, "rb") as coin:
        tile_bytes = bytearray(intro.read())
        tile_bytes += bytearray(coin.read()) # skip 1st tile (transparent)
        
    tiles_dmp = os.path.join(DUMP_FOLDER, "tenhundredtiles.dmp")
    with open(tiles_dmp, "wb") as file:
        file.write(tile_bytes)
    intro_map_dmp, coin_map_dmp = os.path.join(DUMP_FOLDER, "tenhundredintromap.dmp"), os.path.join(DUMP_FOLDER, "tenhundredcoinmap.dmp")
    copyfile(intro_map_bin, intro_map_dmp)
    copyfile(coin_map_bin, coin_map_dmp)
    
    cue_compress_vram(tiles_dmp)
    cue_compress_wram(intro_map_dmp)
    cue_compress_wram(coin_map_dmp)
    
    print(f"wrote {tiles_dmp}, {intro_map_dmp}, {coin_map_dmp}")
    
def cue_compress_vram(file): # 16-bit
    os.system(f"cmd /c ..\\..\\lzss -evo {file}") # overwrites old file with new
    
def cue_compress_wram(file): # 8-bit
    os.system(f"cmd /c ..\\..\\lzss -ewo {file}") # overwrites old file with new
    
def grit_image(img_name, flags):
    os.system(f"cmd /c ..\\grit {img_name} {flags} -o {img_name[:-4]}.bin")
    return f"{img_name[:-4]}.img.bin", f"{img_name[:-4]}.map.bin"
    
def quantize_image_to_palette_and_save(img_file, palette, filename):
    """Quantizes given image to palette, saves and returns path to converted image file"""
    img: Image.Image = Image.open(img_file)

    palImage = Image.new("P", (16, 16))
    palImage.putpalette(palette)
    converted_image = img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)
    converted_file = os.path.join(TEMP_FOLDER, filename)
    converted_image.save(converted_file)
    return converted_file

def main():
    format_ten_and_hundred()

if __name__ == "__main__":
    main()