from PIL import Image
import numpy
import os

# 0x19C284 original ROM
original_palette = [0, 112, 40, 152, 0, 64, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 0, 0, 248, 152, 0, 64, 176, 56, 88, 200, 112, 120, 224, 168, 152, 248, 232, 184]

# https://stackoverflow.com/questions/29433243/convert-image-to-specific-palette-using-pil-without-dithering#29438149
def quantize_to_palette(silf, paletteData, dither=False):
    """Convert an RGB or L mode image to use given palette data."""

    palImage = Image.new("P", (16, 16))
    palImage.putpalette(paletteData)

    silf.load()
    if silf.mode != "RGB" and silf.mode != "L":
        raise ValueError(
            "only RGB or L mode images can be quantized to a palette"
            )
    im = silf.im.convert("P", 1 if dither else 0, palImage.im)
    # the 0 above means turn OFF dithering

    # Later versions of Pillow (4.x) rename _makeself to _new
    try:
        return silf._new(im)
    except AttributeError:
        return silf._makeself(im)

def to_gba(arr):
    arr = arr.astype('<u1')
    
    buffer = split32width(arr).flatten()
    
    buffer = (buffer[1::2] << 4) + buffer[::2]
    return buffer

def split32width(arr):
    """Given image data, split it into 32x16 or 32x32 tiles """
    w, h = arr.shape

    # It just works...
    buffer = arr.reshape(h, w // 32, 32).swapaxes(0, 1).reshape(h // 16 * w // 32, 2, 8, 4, 8).swapaxes(2, 3)
    return buffer

# Adapted from https://github.com/MinN-11/PortraitFormatter/blob/main/portraits2dmp.py
def image_to_dmp(file):
    dump_file = f"../../bin/overworldtitles/{file[:-4]}.dmp"

    image: Image.Image = Image.open(file)
    assert image.width % 32 == 0,  "image width should be a multiple of 32"
    assert image.height % 16 == 0, "image height should be a multiple of 16"
    
    #NEW: Fit image to original palette
    image = image.convert("RGB")
    image = quantize_to_palette(image, original_palette, dither=False)
    
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