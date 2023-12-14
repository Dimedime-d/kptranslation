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

red_white_black_palette = [248, 0, 0, 248, 248, 248, 0, 0, 0] + [160, 160, 160]*253

def format_ten_and_hundred():
    pal = red_white_black_palette # dummy colors
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
    
def format_book_test():
    pal = red_white_black_palette
    img_png_names = [quantize_image_to_palette_and_save(os.path.join(TRICK_FOLDER, f"booktest{i}.png"), pal, f"booktest{i}-converted.png") for i in range(1, 4)]
    
    # Grit flags in order:
    # SHARED tileset, no palette, 4bpp, tile format, force palette bank 2, reg flat map layout, reduce tiles + palette + flip, tile offset 192
    # metatile reduction, 1x1 metatiles, .bin file, no header, map data is BIOS compressed
    shared_tiles = grit_images(img_png_names, f"-gS -p! -gB4 -gt -mp2 -mLf -mRtpf -ma192 -MRp -Mh1 -Mw1 -ftb -fh! -mzl", os.path.join(DUMP_FOLDER, "booktest_"))
    
    # just discovered shared tileset data in grit, don't need to merge tileset data at all :D
    # unfortunately, this results in the .map.bin files being dumped in the directory this script was run in, so need to manually rename files
    for i, name in enumerate(img_png_names):
        src = f"{os.path.basename(name)[:-4]}.map.bin"
        dest = f"{os.path.join(DUMP_FOLDER, f'booktestmap{i+1}.dmp')}"
        if os.path.exists(dest):
            os.remove(dest)
        os.rename(src, dest)
        print(f"wrote {dest}")
        
def format_time_paradox():
    pal = red_white_black_palette
    converted_png = quantize_image_to_palette_and_save(os.path.join(TRICK_FOLDER, "time.png"), pal, "time-converted.png")
   
    # Grit 'em
    # In order: No palette, 4bpp, tile format, force palette bank 2, tile offset 320, reg flat map layout, reduce tiles+pal+flip,
    # metatile reduction, 1x1 metatiles, .bin file, no header
    tiles_bin, map_bin = grit_image(converted_png, "-p! -gB4 -gt -mp2 -ma320 -mLf -mRtpf -MRp -Mh1 -Mw1 -ftb -fh! -mzl")
    
    final_tiles = os.path.join(DUMP_FOLDER, "timetiles.bin")
    if os.path.exists(final_tiles):
        os.remove(final_tiles)
    os.rename(tiles_bin, final_tiles)
    final_map = os.path.join(DUMP_FOLDER, "timemap.dmp")
    if os.path.exists(final_map):
        os.remove(final_map)
    os.rename(map_bin, final_map)
    
    print(f"wrote {final_tiles} and {final_map}")

def format_dont_touch():
    pal = [248, 248, 248, 184, 176, 168, 0, 0, 0, 8, 8, 0, 56, 24, 0, 112, 40, 0, 88, 56, 0, 168, 112, 24, 144, 88, 8, 240, 184, 32, 232, 200, 32, 232, 144, 24, 232, 152, 24, 248, 216, 40, 136, 72, 16, 192, 120, 24] # 7C1638
    converted_png = quantize_image_to_palette_and_save(os.path.join(TRICK_FOLDER, "donttouch.png"), pal, "donttouch-converted.png")
    
    # Grit 'em
    # In order: No palette, 4bpp, tile format, force palette bank 1, tile offset 96, reg flat map layout, reduce tiles+pal+flip,
    # metatile reduction, 1x1 metatiles, .bin file, no header, only tile map is compressed
    tiles_bin, map_bin = grit_image(converted_png, "-p! -gB4 -gt -mp1 -ma96 -mLf -mRtpf -MRp -Mh1 -Mw1 -ftb -fh! -mzl")
    
    final_tiles = os.path.join(DUMP_FOLDER, "donttouchtiles.bin")
    if os.path.exists(final_tiles):
        os.remove(final_tiles)
    os.rename(tiles_bin, final_tiles)
    
    final_map = os.path.join(DUMP_FOLDER, "donttouchmap.dmp")
    if os.path.exists(final_map):
        os.remove(final_map)
    os.rename(map_bin, final_map)
    
    print(f"wrote {final_tiles} and {final_map}")
    
def format_sound_catch():
    pal = [248, 248, 248, 0, 0, 0, 104, 96, 8, 184, 168, 16, 72, 64, 8, 144, 136, 8, 248, 240, 24, 32, 32, 0, 168, 152, 16, 120, 112, 8, 240, 224, 24, 240, 208, 16, 208, 192, 16, 0, 0, 0, 0, 0, 0, 0, 0, 0] # 7AF60C
    converted_png = quantize_image_to_palette_and_save(os.path.join(TRICK_FOLDER, "soundcatch.png"), pal, "soundcatch-converted.png")
    
    # Grit again...
    # In order: No palette, 4bpp, tile format, NO MAP! (these are object tiles), .bin file, no header
    tiles_bin, map_bin = grit_image(converted_png, "-p! -gB4 -gt -m! -ftb -fh!")
    
    final_tiles = os.path.join(DUMP_FOLDER, "soundcatchobj.bin")
    if os.path.exists(final_tiles):
        os.remove(final_tiles)
    os.rename(tiles_bin, final_tiles)
    
    print(f"wrote {final_tiles}")
    
def format_center_point():
    pal = red_white_black_palette
    converted_png = quantize_image_to_palette_and_save(os.path.join(TRICK_FOLDER, "centerpoint.png"), pal, "centerpoint-converted.png")
   
    # Grit 'em
    # In order: No palette, 4bpp, tile format, force palette bank 2, tile offset 320, reg flat map layout, reduce tiles+pal+flip,
    # metatile reduction, 1x1 metatiles, .bin file, no header
    tiles_bin, map_bin = grit_image(converted_png, "-p! -gB4 -gt -mp2 -ma160 -mLf -mRtpf -MRp -Mh1 -Mw1 -ftb -fh! -mzl")
    
    final_tiles = os.path.join(DUMP_FOLDER, "centerpointtiles.bin")
    if os.path.exists(final_tiles):
        os.remove(final_tiles)
    os.rename(tiles_bin, final_tiles)
    final_map = os.path.join(DUMP_FOLDER, "centerpointmap.dmp")
    if os.path.exists(final_map):
        os.remove(final_map)
    os.rename(map_bin, final_map)
    
    print(f"wrote {final_tiles} and {final_map}")
    
def format_imagine():
    pal = [0, 0, 0, 32, 0, 16, 40, 8, 40, 8, 8, 72, 16, 16, 112, 24, 24, 144, 48, 48, 176, 64, 64, 144, 80, 96, 160, 96, 128, 160, 136, 136, 136, 112, 144, 160, 120, 152, 152, 152, 144, 136, 144, 160, 152, 0, 0, 0] # 7B5BE0
    converted_png = quantize_image_to_palette_and_save(os.path.join(TRICK_FOLDER, "imagine.png"), pal, "imagine-converted.png")
    
    # Grit
    # In order: No palette, 8bpp (!), bitmapped graphics, lzss compressed, no tile map
    tiles_bin, map_bin = grit_image(converted_png, "-p! -gB8 -gb -gzl -m!")
    
    final_bitmap = os.path.join(DUMP_FOLDER, "imaginebitmap.dmp")
    if os.path.exists(final_bitmap):
        os.remove(final_bitmap)
    os.rename(tiles_bin, final_bitmap)
    
    print(f"wrote {final_bitmap}")
    
def cue_compress_vram(file): # 16-bit
    os.system(f"cmd /c ..\\..\\lzss -evo {file}") # overwrites old file with new
    
def cue_compress_wram(file): # 8-bit
    os.system(f"cmd /c ..\\..\\lzss -ewo {file}") # overwrites old file with new

def grit_images(img_names, flags, shared_output):
    os.system(f"cmd /c ..\\grit {" ".join(img_names)} {flags} -O {shared_output}.bin")
    return f"{shared_output}.img.bin"

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
    # Kururin shock has no JP graphics
    format_ten_and_hundred()
    format_book_test()
    format_time_paradox()
    format_sound_catch()
    format_center_point()
    #Game boy panic, impression, twist have nothing
    format_imagine()
    
    format_dont_touch()

if __name__ == "__main__":
    main()