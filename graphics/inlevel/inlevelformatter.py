# Auto-generates a .asm file to insert the (hardcoded named) .dmp files
from collections import OrderedDict
import os
from PIL import Image

text_palette = [32, 88, 112, 0, 0, 0, 0, 0, 0, 88, 88, 88, 208, 208, 200, 136, 160, 152, 112, 216, 248, 0, 72, 128, 120, 160, 184, 248, 248, 248, 0, 0, 248, 0, 104, 176, 56, 136, 192, 120, 176, 208, 184, 208, 224, 248, 248, 248] # same for in-level dialogue box and level name
TEMP_FOLDER = "reserve"
DUMP_FOLDER = "dumps"

dialog_macro = """.macro inleveldialogueheader
	.byte   0x0C,0x00,0x78,0x50  \
            0xB0,0x28,0x44,0x10, \
            0xD0,0x28,0x44,0x10, \
			0xF0,0x28,0x44,0x10, \
            0x10,0x28,0x44,0x10, \
            0x30,0x28,0x44,0x10, \
            0x50,0x28,0x44,0x10, \
            0xB0,0x48,0x14,0x04, \
            0xD0,0x48,0x14,0x04, \
			0xF0,0x48,0x14,0x04, \
            0x10,0x48,0x14,0x04, \
            0x30,0x48,0x14,0x04, \
            0x50,0x48,0x14,0x04 \
.endmacro
"""

ordered_levels = ["training1", "training2", "training3", "training4", "training5",
    "village1", "village2", "village3", "village4", "village5", "village5a", "village4a", "village4b",
    "flower1", "flower2", "flower3", "flower4", "flower5", "flower5a", "flower3a", "flower3b",
    "clock1", "clock2", "clock3", "clock4", "clock5", "clock4a", "clock3a", "clock3b",
    "magic1", "magic2", "magic3", "magic4", "magic5", "magic6", "magic4a", "magic4aa", "magic4ab",
    "neo1", "neo2", "neo3", "neo4"]

bs = '\\'

titles = OrderedDict()

def make_title_dmps():
    for lvl in ordered_levels:
        base_img_file = f"{lvl}title.png"
        converted_img_file, width = quantize_image_to_palette_and_save(base_img_file, text_palette)
        bin_file = os.path.join(DUMP_FOLDER, f"{lvl}title")
        # In order: No palette, 4bpp, tile format, NO MAP,
        # 4x2 metatiles, .bin file, no header, output file
        os.system(f"cmd /c ..\\grit {converted_img_file} -p! -gB4 -gt -m! -Mw4 -Mh2 -ftb -fh! -o {bin_file}")
        dmp_file = f"{bin_file}.dmp"
        if os.path.exists(dmp_file):
            os.remove(dmp_file)
        os.rename(f"{bin_file}.img.bin", dmp_file)
        print(f"wrote {dmp_file}")
        titles[lvl] = {"header" : f"inleveltitleheader{width // 32}"}
        titles[lvl]["dmp"] = os.path.join("graphics", "inlevel", dmp_file)
    
def quantize_image_to_palette_and_save(img_file, palette):
    """Quantizes given image to palette, saves and returns path to converted image file, + width"""
    img: Image.Image = Image.open(img_file)
    assert img.width % 32 == 0 and img.height == 16,  f"{img_file} does not match proper dimensions for tiling (needs to be 32x16 blocks)"
    
    palImage = Image.new("P", (16, 16))
    palImage.putpalette(palette + [0, 0, 0] * 240)
    converted_image = img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)
    converted_file = os.path.join(TEMP_FOLDER, f"{img_file[:-4]}-converted.png")
    converted_image.save(converted_file)
    return converted_file, converted_image.width

def make_asm_file():
    with open("inleveltext.asm", "w") as file:
        file.write(f"""; This file was automatically generated by dialogformatter.py
    
.macro inleveldialogueheader
	.byte   0x0C,0x00,0x78,0x50, {bs}
            0xB0,0x28,0x44,0x10, {bs}
            0xD0,0x28,0x44,0x10, {bs}
			0xF0,0x28,0x44,0x10, {bs}
            0x10,0x28,0x44,0x10, {bs}
            0x30,0x28,0x44,0x10, {bs}
            0x50,0x28,0x44,0x10, {bs}
            0xB0,0x48,0x14,0x04, {bs}
            0xD0,0x48,0x14,0x04, {bs}
			0xF0,0x48,0x14,0x04, {bs}
            0x10,0x48,0x14,0x04, {bs}
            0x30,0x48,0x14,0x04, {bs}
            0x50,0x48,0x14,0x04
.endmacro    

.macro inleveltitleheader3 ; 3 blocks, centered
    .byte   0x03,0x20,0x78,0x50, {bs}
            0xD0,0xF8,0x24,0x08, {bs}
            0xF0,0xF8,0x24,0x08, {bs}
            0x10,0xF8,0x24,0x08
.endmacro

.macro inleveltitleheader4 ; 4 blocks, centered
    .byte   0x04,0x20,0x68,0x50, {bs}
            0xD0,0xF8,0x24,0x08, {bs}
            0xF0,0xF8,0x24,0x08, {bs}
            0x10,0xF8,0x24,0x08, {bs}
            0x30,0xF8,0x24,0x08
.endmacro

.macro inleveltitleheader5 ; 5 blocks, centered
    .byte   0x05,0x20,0x58,0x50, {bs}
            0xD0,0xF8,0x24,0x08, {bs}
            0xF0,0xF8,0x24,0x08, {bs}
            0x10,0xF8,0x24,0x08, {bs}
            0x30,0xF8,0x24,0x08, {bs}
            0x50,0xF8,0x24,0x08
.endmacro

.org 0x082AAE34
.region 0x082E4E24 - org() ; space taken up by original in-level titles + text boxes""")
        file.write("".join([f"\n\t@{lvl}Title: :: {titles[lvl]['header']}\n\t.incbin \"{titles[lvl]['dmp']}\" :: .align" for lvl in titles]))
        
        file.write("\n")

        file.write("".join([f"\n\t@{lvl}Text: :: inleveldialogueheader\n\t.incbin \"{os.path.join('graphics', 'inlevel', 'dumps', lvl)}.dmp\" :: .align" for lvl in ordered_levels]))
        file.write("\n.endregion\n\n")
        
        file.write(".org 0x08029694 ; repointing in-level titles")
        file.write("".join([f"\n\t.word @{lvl}Title" for lvl in ordered_levels]))
        
        file.write("\n.org 0x0802973C ; repointing in-level text boxes")
        file.write("".join([f"\n\t.word @{lvl}Text" for lvl in ordered_levels]))
    
def main():
    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)
    make_title_dmps()
    make_asm_file()

if __name__ == "__main__":
    main()