# Formats miscellaneous tile-based data, specifically, the bold yellow headers showing the magic trick name, as well as the little 88x88 pictures that demonstrate certain steps
# in addition, the preview screens before selecting "Learn or Perform"

from PIL import Image
import os
import struct
import sys

sys.path.append("..")
from compression import LZ

# see customcode.asm for repointing binaries

TEMP_FOLDER = "reserve" # intermediate files
DUMP_FOLDER = "dumps" # binaries ready to be inserted
PREVIEW_FOLDER = "preview" # preview images to keep separate

DUMMY_COLOR = [0, 0, 0]

pic_palettes = [[248, 0, 248, 248, 0, 0, 0, 0, 0, 176, 176, 176, 168, 96, 0, 144, 248, 248, 120, 120, 120, 24, 0, 160, 112, 64, 0, 96, 0, 240, 248, 248, 248, 48, 48, 48, 24, 248, 0, 136, 160, 192, 248, 0, 248, 0, 0, 0],
[248, 0, 248, 16, 16, 0, 24, 0, 160, 48, 56, 0, 96, 0, 240, 248, 0, 0, 168, 96, 0, 176, 176, 176, 248, 208, 128, 248, 248, 248, 0, 0, 0, 208, 160, 104, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 248, 0, 248, 128, 56, 248, 0, 0, 248, 248, 152, 184, 184, 184, 176, 176, 176, 16, 56, 248, 0, 0, 0, 248, 248, 248, 192, 160, 72, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[248, 0, 248, 248, 0, 0, 88, 80, 80, 16, 248, 0, 176, 176, 176, 248, 184, 0, 248, 208, 128, 216, 208, 208, 248, 248, 248, 0, 0, 0, 176, 128, 48, 152, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[248, 0, 248, 96, 0, 240, 248, 0, 0, 88, 80, 80, 16, 248, 0, 176, 176, 176, 192, 192, 168, 216, 208, 208, 224, 232, 224, 248, 248, 248, 0, 0, 0, 136, 136, 136, 72, 0, 152, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 248, 0, 16, 16, 8, 56, 40, 24, 248, 0, 0, 168, 96, 0, 248, 144, 0, 176, 176, 176, 248, 184, 0, 248, 176, 56, 248, 208, 128, 248, 248, 248, 0, 0, 0, 184, 144, 0, 184, 120, 0, 0, 0, 0, 0, 0, 0],
[0, 248, 0, 248, 176, 224, 248, 136, 136, 248, 128, 0, 144, 248, 248, 96, 0, 240, 0, 0, 0, 248, 248, 248, 96, 168, 216, 176, 112, 160, 248, 208, 112, 192, 192, 192, 192, 96, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[248, 0, 248, 112, 56, 0, 248, 0, 0, 248, 208, 128, 200, 248, 120, 248, 248, 248, 0, 0, 0, 168, 136, 56, 184, 184, 176, 104, 184, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 248, 0, 112, 56, 0, 248, 0, 0, 248, 0, 0, 248, 208, 128, 248, 232, 40, 248, 248, 248, 0, 0, 0, 176, 144, 72, 160, 0, 0, 152, 144, 0, 176, 168, 176, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 224, 0, 168, 96, 0, 176, 176, 176, 248, 184, 0, 144, 248, 248, 248, 248, 248, 0, 0, 0, 40, 160, 248, 184, 192, 192, 104, 40, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
[0, 0, 0, 224, 112, 0, 0, 64, 104, 224, 96, 0, 24, 40, 128, 8, 64, 16, 232, 152, 0, 56, 128, 0, 120, 224, 152, 88, 104, 0, 56, 64, 0, 32, 168, 104, 16, 224, 8, 16, 64, 96, 48, 80, 16, 248, 32, 128]]

_header_palette = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 208, 168, 168, 248, 248, 168] # last 2 colors are all I need...
header_palette = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 72, 152, 184, 136, 200, 240] # got too lazy and just copied the big letters over from minigame splash screens, just put the blue colors in the right spots...
# header_palette = [0, 0, 0, 152, 56, 168, 160, 64, 168, 160, 80, 176, 168, 88, 176, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 160, 80, 176, 208, 168, 168, 248, 248, 168]

preview_text_palette = [0, 0, 0, 224, 80, 80, 168, 0, 32, 208, 88, 104, 248, 184, 184, 192, 56, 56, 216, 136, 72, 248, 224, 96, 152, 0, 0, 248, 144, 144, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 248, 248, 248]
preview_pic_palettes = [
[248, 0, 240, 40, 0, 160, 64, 0, 248, 88, 80, 80, 0, 136, 248, 144, 136, 152, 0, 192, 248, 248, 144, 0, 176, 176, 176, 0, 248, 0, 248, 168, 104, 248, 200, 0, 248, 224, 0, 248, 248, 0, 216, 104, 48, 0, 0, 8], # had to change color 0 and color 15
[248, 0, 240, 0, 0, 104, 136, 72, 0, 0, 80, 248, 160, 80, 16, 104, 104, 104, 192, 96, 16, 128, 120, 120, 0, 192, 248, 216, 128, 8, 152, 144, 144, 248, 168, 56, 184, 184, 184, 248, 224, 0, 240, 240, 240, 0, 0, 8],
[248, 0, 240, 24, 0, 144, 24, 0, 208, 160, 0, 0, 96, 48, 0, 136, 0, 208, 248, 0, 0, 208, 0, 168, 152, 72, 0, 248, 40, 0, 168, 112, 0, 240, 160, 0, 200, 200, 192, 240, 224, 0, 248, 248, 216, 0, 0, 8],
[248, 0, 240, 64, 64, 64, 0, 152, 0, 0, 208, 0, 184, 112, 16, 0, 248, 0, 80, 248, 0, 176, 176, 176, 248, 184, 0, 128, 248, 0, 248, 192, 112, 200, 248, 0, 216, 208, 208, 248, 248, 0, 248, 248, 248, 0, 0, 8],
[248, 0, 240, 144, 8, 0, 248, 0, 0, 0, 176, 0, 0, 128, 248, 184, 112, 64, 0, 192, 248, 0, 248, 0, 248, 96, 248, 248, 144, 248, 248, 168, 104, 248, 200, 0, 248, 160, 248, 248, 184, 248, 248, 208, 248, 0, 0, 8],
[248, 0, 240, 80, 56, 0, 248, 0, 0, 80, 80, 80, 248, 32, 0, 248, 80, 0, 200, 112, 8, 248, 112, 0, 248, 120, 0, 248, 152, 0, 176, 176, 168, 248, 184, 0, 248, 200, 0, 248, 192, 112, 208, 208, 208, 0, 0, 8],
[248, 0, 240, 128, 0, 248, 160, 0, 248, 176, 0, 248, 80, 80, 80, 200, 0, 248, 232, 0, 248, 144, 120, 120, 184, 136, 0, 248, 136, 0, 200, 176, 0, 248, 184, 0, 192, 184, 184, 248, 224, 0, 232, 224, 224, 0, 0, 8],
[248, 0, 240, 152, 0, 0, 0, 24, 248, 248, 0, 0, 240, 0, 200, 0, 160, 176, 200, 104, 184, 248, 72, 216, 200, 176, 72, 0, 248, 248, 248, 192, 240, 248, 248, 0, 248, 248, 72, 248, 248, 128, 248, 248, 192, 0, 0, 8],
[248, 0, 240, 40, 40, 40, 24, 0, 192, 160, 0, 0, 56, 56, 56, 248, 0, 0, 72, 56, 248, 248, 40, 0, 104, 104, 104, 248, 80, 0, 248, 120, 0, 152, 144, 144, 248, 200, 0, 200, 200, 192, 240, 240, 240, 0, 0, 8],
[248, 0, 240, 56, 0, 160, 136, 8, 144, 128, 0, 192, 248, 0, 0, 168, 0, 248, 80, 80, 88, 88, 80, 80, 168, 88, 0, 216, 112, 0, 144, 136, 136, 176, 176, 176, 248, 184, 0, 192, 184, 184, 240, 192, 96, 0, 0, 8],
[248, 0, 240, 120, 0, 248, 192, 0, 168, 176, 8, 248, 248, 0, 136, 248, 48, 208, 248, 88, 224, 88, 176, 248, 248, 120, 216, 152, 216, 248, 248, 176, 224, 248, 192, 240, 152, 248, 248, 248, 216, 248, 248, 248, 248, 0, 0, 8],
[248, 0, 240, 104, 0, 40, 144, 56, 24, 16, 96, 248, 16, 120, 248, 144, 88, 200, 16, 160, 248, 248, 112, 0, 184, 104, 248, 248, 104, 240, 248, 176, 0, 128, 200, 248, 248, 160, 248, 232, 248, 136, 248, 248, 248, 0, 0, 8],
[248, 0, 240, 24, 0, 104, 136, 0, 0, 80, 56, 80, 176, 0, 136, 0, 120, 152, 112, 104, 144, 120, 120, 184, 144, 128, 104, 0, 200, 248, 200, 176, 32, 248, 192, 248, 248, 224, 0, 248, 240, 184, 248, 248, 248, 0, 0, 8],
[248, 0, 240, 64, 0, 248, 176, 0, 104, 248, 0, 0, 80, 80, 80, 248, 48, 8, 216, 64, 56, 248, 104, 32, 248, 136, 0, 176, 168, 160, 248, 176, 0, 248, 216, 0, 248, 232, 8, 248, 248, 0, 240, 240, 224, 0, 0, 8],
[248, 0, 240, 0, 8, 128, 0, 8, 168, 0, 24, 208, 64, 56, 56, 0, 48, 224, 248, 0, 0, 104, 88, 88, 144, 128, 128, 240, 136, 0, 168, 152, 152, 128, 208, 248, 200, 184, 184, 152, 248, 248, 232, 232, 224, 0, 0, 8],
[248, 0, 240, 16, 32, 216, 168, 0, 136, 72, 16, 248, 208, 0, 176, 104, 56, 248, 248, 40, 216, 80, 72, 64, 224, 96, 0, 216, 112, 248, 176, 176, 176, 248, 144, 0, 136, 232, 248, 248, 200, 0, 224, 216, 216, 0, 0, 8],
]

def make_pic_dmps():
    for path, dirs, files in os.walk("pics"):
        for pic in files:
            img_file = os.path.join(path, pic)
            try:
                index = int(pic[:-4])
            except:
                print(f"Error, {pic} is not named properly (must be an integer)")
            palette = pic_palettes[index]
            
            converted_file = quantize_image_to_palette_and_save(img_file, palette, filename=f"pic{img_file[5:-4]}-converted.png")
            
            # given absolute file path...
            bin_file = f"{os.path.join(DUMP_FOLDER, f'pic{os.path.basename(img_file[:-4])}')}"
            # the raw file that grit spits out
            
            # in order: no palette (we already requantized), 4bpp, transparent color, 4x4 metatiles, .bin file, no header, output file
            os.system(f"cmd /c ..\\grit {converted_file} -p! -gB4 -gt -Mh4 -Mw4 -ftb -fh! -o {bin_file}")
            dmp_file = f"{bin_file}.dmp"
            if os.path.exists(dmp_file):
                os.remove(dmp_file)
            os.rename(f"{bin_file}.img.bin", dmp_file)
            print(f"wrote {dmp_file}")
            
def make_preview_dmps():
    for i in range(16):
        text_png, pic_png = os.path.join(PREVIEW_FOLDER, f"text{i}.png"), os.path.join(PREVIEW_FOLDER, f"pic{i}.png")
        text_palette = preview_text_palette + DUMMY_COLOR*240
        pic_palette = DUMMY_COLOR*16 + preview_pic_palettes[i] + DUMMY_COLOR*224

        try:
            # Quantize
            converted_text_png = quantize_image_to_palette_and_save(text_png, text_palette, f"{os.path.basename(text_png)[:-4]}-converted.png")
            converted_pic_png = quantize_image_to_palette_and_save(pic_png, pic_palette, f"{os.path.basename(pic_png)[:-4]}-converted.png")

            # Grit
            # In order: No palette, 4bpp, tile format, reg flat map layout, reduce tiles+pal+flip,
            # metatile reduction, 1x1 metatiles, .bin file, no header, output file
            os.system(f"cmd /c ..\\grit {converted_text_png} -p! -gB4 -gt -mLf -mRtpf -MRp -Mh1 -Mw1 -ftb -fh! -o {converted_text_png[:-4]}.bin")
            text_tileset_bin = f"{converted_text_png[:-4]}.img.bin"
            text_tilemap_bin = f"{converted_text_png[:-4]}.map.bin"
            # Use size of text tileset to determine offset of tile map
            pic_tilemap_offset = os.path.getsize(text_tileset_bin) // 0x20 - 1
            
            # In order: No palette, 4bpp, tile format, reg flat map layout, reduce tiles+pal+flip,
            # metatile reduction, 1x1 metatiles, .bin file, no header, output file
            os.system(f"cmd /c ..\\grit {converted_pic_png} -p! -gB4 -gt781F -mLf -mRtpf -ma{pic_tilemap_offset} -MRp -Mh1 -Mw1 -ftb -fh! -o {converted_pic_png[:-4]}.bin")
            pic_tileset_bin = f"{converted_pic_png[:-4]}.img.bin"
            pic_tilemap_bin = f"{converted_pic_png[:-4]}.map.bin"
            # All binaries are uncompressed so far...
            
            # Merge 'em
            uncomp_tiles, uncomp_map = merge_binaries(text_tileset_bin, text_tilemap_bin, pic_tileset_bin, pic_tilemap_bin)
            
            with open(os.path.join(TEMP_FOLDER, f"previewtileset{i}.bin"), "wb") as f1:
                f1.write(uncomp_tiles)
            with open(os.path.join(TEMP_FOLDER, f"previewmap{i}.bin"), "wb") as f2:
                f2.write(uncomp_map)
            
            # Performance bottleneck is here, unsurprisingly. 
            comp_tiles, comp_map = LZ.compress(uncomp_tiles), LZ.compress(uncomp_map)
            
            final_tiles_dmp, final_map_dmp = os.path.join(DUMP_FOLDER, f"preview{i}tiles.dmp"), os.path.join(DUMP_FOLDER, f"preview{i}map.dmp")
            
            with open(final_tiles_dmp, "wb") as tiles, open(final_map_dmp, "wb") as map:
                tiles.write(struct.pack("<I", len(uncomp_tiles))) # the decompression method for these tilesets/maps reads the first dword as uncompressed length
                tiles.write(comp_tiles)
                map.write(struct.pack("<I", len(uncomp_map))) # should be 4B0, always
                map.write(comp_map)
                
            print(f"wrote {final_tiles_dmp} and {final_map_dmp}")
        
        except FileNotFoundError:
            print(f"Preview file {i} not found")
            
def merge_binaries(text_tiles, text_map, pic_tiles, pic_map):
    tile_bytes = None
    with open(text_tiles, "rb") as txt, open(pic_tiles, "rb") as pic:
        tile_bytes = bytearray(txt.read())
        pic_tile_bytes  = bytearray(pic.read())
        tile_bytes += pic_tile_bytes[32:] # Skip 1st tile in picture tileset (the transparent tile)
    
    map_bytes = None
    # Given x/y coordinates in 8x8 tiles, return offset of binary data
    def byteindex(x, y):
        return 60*x + 2*y
    
    # Merge maps
    with open(text_map, "rb") as txt, open(pic_map, "rb") as pic:
        map_bytes = bytearray(txt.read())
        pic_map_bytes = bytearray(pic.read())
        ulx, uly = 21, 1
        for i in range(uly, uly+8, 1):
            # Replace a 8x8 grid of 8x8 tiles in the main map from those of the picture
            map_bytes[byteindex(i, ulx):byteindex(i, ulx+8)] = pic_map_bytes[byteindex(i, ulx):byteindex(i, ulx+8)]
    
    return tile_bytes, map_bytes

HEADER_FOLDER = "header"
def make_header_dmps():
    for i in range(16):
        header_png = os.path.join(HEADER_FOLDER, f"header{i}.png")
        header_pal = DUMMY_COLOR*32 + header_palette + DUMMY_COLOR*208
        
        try:
            converted_header_png = quantize_image_to_palette_and_save(header_png, header_pal, f"{os.path.basename(header_png)[:-4]}-converted.png")
            # Grit
            # In order: No palette, 4bpp, tile format, force palette bank 2, reg flat map layout, reduce tiles+pal+flip,
            # metatile reduction, 1x1 metatiles, .bin file, no header, output file
            os.system(f"cmd /c ..\\grit {converted_header_png} -p! -gB4 -gt -mp2 -mLf -mRtpf -MRp -Mh1 -Mw1 -ftb -fh! -o {converted_header_png[:-4]}.bin")
            header_tileset_bin = f"{converted_header_png[:-4]}.img.bin"
            header_tilemap_bin = f"{converted_header_png[:-4]}.map.bin"
            
            tileset_bytes, tilemap_bytes = None, None
            with open(header_tileset_bin, "rb") as tileset, open(header_tilemap_bin, "rb") as tilemap:
                tileset_bytes = tileset.read()
                tilemap_bytes = tilemap.read()
                
            comp_tiles, comp_map = LZ.compress(tileset_bytes), LZ.compress(tilemap_bytes)
            
            final_tiles_dmp, final_map_dmp = os.path.join(DUMP_FOLDER, f"header{i}tiles.dmp"), os.path.join(DUMP_FOLDER, f"header{i}map.dmp")
            
            with open(final_tiles_dmp, "wb") as tiles, open(final_map_dmp, "wb") as map:
                tiles.write(struct.pack("<I", len(tileset_bytes))) # the decompression method for these tilesets/maps reads the first dword as uncompressed length
                tiles.write(comp_tiles)
                map.write(struct.pack("<I", len(tilemap_bytes))) # should be 4B0, always
                map.write(comp_map)
                
            print(f"wrote {final_tiles_dmp} and {final_map_dmp}")
            
        except FileNotFoundError:
            print(f"Header file {i} not found")
            
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
    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)
    make_pic_dmps() # 88x88 pictures that appear in instructions
    make_preview_dmps()
    make_header_dmps()
    
if __name__ == "__main__":
    main()
            
            
            
            