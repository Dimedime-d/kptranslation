from PIL import Image
import numpy
import os

# 0x19C284 original ROM
original_palette = [0, 112, 40, 152, 0, 64, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 152, 0, 64, 176, 56, 88, 200, 112, 120, 224, 168, 152, 248, 232, 184]

#https://stackoverflow.com/a/237193
def quantize_to_palette(img, palette, dither=Image.NONE):
    palImage = Image.new("P", (1, 1))
    palImage.putpalette(palette + [0, 0, 0] * 240)
    return img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)

def to_gba(arr):
    arr = arr.astype('<u1')
    
    buffer = split32width(arr).flatten()
    
    # 4bpp (4 bits per palette) - interweave each digit
    buffer = (buffer[1::2] << 4) + buffer[::2]
    return buffer

def split32width(arr):
    """Given image data, split it into 32x16 or 32x32 tiles """
    w, h = arr.shape

    # It just works...
    # Ex: with a 96x16 image... reshape to 16x3x32, then 3x16x32, then 3x2x8x4x8, then 3x2x4x8x8
    # 1st dimension is how many blocks, last 2 dimensions contain 8x8 pixel data, organized into 32x16 or 32x32 "metatiles"
    buffer = arr.reshape(h, w // 32, 32).swapaxes(0, 1).reshape(h // 16 * w // 32, 2, 8, 4, 8).swapaxes(2, 3)
    return buffer

# Adapted from https://github.com/MinN-11/PortraitFormatter/blob/main/portraits2dmp.py
def image_to_dmp(file):
    dump_file = f"dumps/{file[:-4]}.dmp"

    image: Image.Image = Image.open(file)
    assert image.width % 32 == 0,  f"{file}: image width should be a multiple of 32"
    assert image.height % 16 == 0, f"{file}: image height should be a multiple of 16"
    
    #NEW: Fit image to original palette
    image = image.convert("RGB")
    image = quantize_to_palette(image, original_palette)
    
    # Little-endian unsigned 8-bit int array, with dimensions of the original image
    arr = numpy.array(image.getdata(), dtype='<u1').reshape(image.width, image.height)
    
    imgBytes = to_gba(arr).tobytes()
    
    with open(dump_file, "wb") as file:
        file.write(imgBytes)
        print(f"wrote {dump_file}")

def main():
    for file in os.listdir("."):
        if not file.endswith(".png"):
            continue
        image_to_dmp(file)
    
if __name__ == "__main__":
    main()