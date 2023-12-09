# Formats miscellaneous tile-based data, specifically, the bold yellow headers showing the magic trick name, as well as the little 88x88 pictures that demonstrate certain steps

from PIL import Image
import os

# see customcode.asm for repointing binaries

TEMP_FOLDER = "reserve" # intermediate files
DUMP_FOLDER = "dumps" # binaries ready to be inserted

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

header_palette = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 208, 168, 168, 248, 248, 168] # last 2 colors are all I need...
# header_palette = [0, 0, 0, 152, 56, 168, 160, 64, 168, 160, 80, 176, 168, 88, 176, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 160, 80, 176, 208, 168, 168, 248, 248, 168]


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
    make_pic_dmps()
    
if __name__ == "__main__":
    main()
            
            
            
            