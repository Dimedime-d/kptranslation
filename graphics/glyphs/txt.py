import os
from pprint import pprint
import struct
from dataclasses import dataclass, field
from enum import Enum
from PIL import Image

TEMP_FOLDER = "reserve"
DUMP_FOLDER = "dumps"
path_to_rom = "../../kp.gba"

bs = "\\"

text_pal = [32, 152, 160, 0, 0, 0, 32, 152, 160, 240, 152, 152, 0, 64, 144, 0, 96, 160, 0, 128, 184, 184, 72, 0, 200, 128, 16, 224, 184, 40, 248, 248, 64, 0, 0, 0, 56, 56, 56, 120, 120, 120, 184, 184, 184, 248, 248, 248] # 0x1C65D0

class TileSize(Enum):
    EIGHT_SQUARE = 0x11
    SIXTEEN_WIDE = 0x12
    SIXTEEN_TALL = 0x21
    SIXTEEN_SQUARE = 0x22

def combine_images_y(*imgs):
    img = Image.new("P", (max([i.width for i in imgs]), sum([i.height for i in imgs])))
    img.putpalette(text_pal + [0, 0, 0] * 240)
    h = 0
    for i in imgs:
        img.paste(i, (0, h))
        h += i.height
    return img
    
def combine_images_x(*imgs):
    img = Image.new("P", (sum([i.width for i in imgs]), max([i.height for i in imgs])))
    img.putpalette(text_pal + [0, 0, 0] * 240)
    w = 0
    for i in imgs:
        img.paste(i, (w, 0))
        w += i.width
    return img

@dataclass(slots=True)
class Char:
    """More readable format of getting metadata from chars"""
    MIN_Y_OFFSET = -7 # used by the circle numbers
    
    char: str
    char_code: str # character code in table
    offset: int # original object data located in the ROM
    tbl_offset: int # offset of the relative offset to the object data offset (.org here to repoint the object data)
    
    obj_count: int
    unk2: int
    unk3: int
    unk4: int
    
    x_offset: int
    y_offset: int
    size: int
    block_count: int
    
    orig_binaries: list
    img: Image
    
    char_width: int
    char_height: int
    
    bin_file: str
    armips_label: str
    
    def __init__(self, file, code, c = "UNKNOWN", tbl_offset = -1):
        # Assume each glyph takes up 1 object (makes sense, right?)
        self.char = c
        self.char_code = code
        self.offset = file.tell()
        self.tbl_offset = tbl_offset
        self.obj_count, self.unk2, self.unk3, self.unk4 = struct.unpack("<bbbb", file.read(4))
        self.x_offset, self.y_offset, self.size, self.block_count = struct.unpack("<bbbb", file.read(4))
        self.orig_binaries = list()
        for i in range(self.block_count):
            self.orig_binaries.append(file.read(32))
        if self.obj_count != 0:
            self.img = self.get_image()
        else:
            self.img = Image.new("P", (1, 1))
        self.img.putpalette(text_pal + [0, 0, 0] * 240)
        self.char_width, self.char_height = self.compute_glyph_dimensions()
        
        self.bin_file = os.path.join(DUMP_FOLDER, f"{hex(self.char_code)}.img.bin")
        self.armips_label = f"@glyph_{hex(self.char_code)}"
    
    def get_image(self):
        '''By default, every obj tile's data starts from the top left, and its x and y-positions are adjusted by the object's header data.'''
        tile_blocks = list()
        for b in self.orig_binaries:
            tile_blocks.append(self.create_4bpp_block(b))
        return self.piece_blocks_together(tile_blocks)
        
    def normalize_image(self):
        '''Force the same y-offset (-7) and same block size (16x16), adjusting the position of the glyph accordingly
        Effectively, this should make every glyph have the same header data
        I already checked beforehand that no glyph that I'm using gets cut off at the bottom...
        '''
        y_pos = -Char.MIN_Y_OFFSET + self.y_offset # -7 -> don't change, -5 -> shift image down by 2 px
        new_img = Image.new("P", (16, 16))
        new_img.putpalette(text_pal + [0, 0, 0] * 240)
        new_img.paste(self.img, (0, y_pos))
        
        # Update state
        self.img = new_img
        self.y_offset = -7
        self.size = TileSize.SIXTEEN_SQUARE
        self.block_count = 4
        
    def format(self):
        '''Unless I'm need to make custom glyphs for whatever reason, this should be a one-time job.
        Also, returns the .incbin for the .img.bin file that grit spits out (armips label included)'''
        
        # The limitations of grit strikes again (need to output image to a file to feed in.), but it's way better than manually trying to block out all the data...
        img_filename = os.path.join(TEMP_FOLDER, f"{hex(self.char_code)}.png")
        self.img.save(img_filename)
        
        # In order: No palette, 4bpp, tile format, NO MAP,
        # 2x2 metatiles, .bin file, no header, output file
        os.system(f"cmd /c ..\grit {img_filename} -p! -gB4 -gt -m! -Mw2 -Mh2 -ftb -fh! -o {self.bin_file}")
        
    def get_repoint_asm(self):
        return f""".org {hex(self.tbl_offset + 0x8000000)}
    .word {self.armips_label} - 0x08284F70"""
        
    def get_incbin_asm(self):
        return f'''    @glyph_{hex(self.char_code)}:
    universal_glyph_header
        .incbin "{os.path.join("graphics", "glyphs", self.bin_file)}"''' # armips is senstive to double quotes
        
    
    def compute_glyph_dimensions(self):
        # getpixel returns palette index, sum palette indeces to determine if row/column contains part of the glyph
        row_sums    = [sum([self.img.getpixel((x, y)) for x in range(self.img.width)]) for y in range(self.img.height)]
        column_sums = [sum([self.img.getpixel((x, y)) for y in range(self.img.height)]) for x in range(self.img.width)]
        top = next((i for i, x in enumerate(row_sums) if x), 0)
        bot = self.img.height - next((i for i, x in enumerate(reversed(row_sums)) if x), 0)
        left = next((i for i, x in enumerate(column_sums) if x), 0)
        right = self.img.width - next((i for i, x in enumerate(reversed(column_sums)) if x), 0)
        return abs(left - right), abs(top - bot)
        
    def polarize_image(self):
        pixels = self.img.load()
        for y in range(self.img.height):
            for x in range(self.img.width):
                if pixels[x, y] in range(1, 15):
                    pixels[x, y] = 15
        
    @staticmethod
    def create_4bpp_block(data):
        img = Image.new("P", (8, 8))
        img.putpalette(text_pal + [0, 0, 0] * 240)
        data_ind = 0
        pixels = img.load()
        for y in range(img.height):
            for x in range(img.width):
                pal_ind = -1
                if x % 2 == 0:
                    pal_ind = data[data_ind] & 0xF # lower4
                else:
                    pal_ind = (data[data_ind] >> 4) & 0xF # upper4
                    data_ind += 1
                pixels[x, y] = pal_ind
                #img.putpixel((x, y), tuple(text_pal[pal_ind*3 : pal_ind*3 + 3]))
        return img
        
    def piece_blocks_together(self, images):
        full_img = None
        match TileSize(self.size):
            case TileSize.EIGHT_SQUARE:
                full_img = images[0]
            case TileSize.SIXTEEN_TALL:
                full_img = combine_images_y(images[0], images[1])
            case TileSize.SIXTEEN_WIDE:
                full_img = combine_images_x(images[0], images[1])
            case TileSize.SIXTEEN_SQUARE:
                full_img = combine_images_y(
                    combine_images_x(images[0], images[1]),
                    combine_images_x(images[2], images[3]))
            case _:
                full_img = Image.new("P", (8, 8))
        return full_img

    def __str__(self):
        return f"Char({self.char=}, char_code={hex(self.char_code)} offset={hex(self.offset)}, {self.obj_count=}, {self.unk2=}, {self.unk3=}, {self.unk4=}, {self.x_offset=}, {self.y_offset=}, {TileSize(self.size)}, {self.block_count=}, {self.char_width=}, {self.char_height=})"

def tbl_offset_to_char_code(file, offset):
    if offset in range(0x39808, 0x39B08):
        return int((offset - 0x39808) // 4) + 0x8140
    if offset in range(0x39B08, 0x39E08):
        return int((offset - 0x39B08)) // 4 + 0x8240
    if offset in range(0x39E08, 0x39F88):
        return int((offset - 0x39E08) // 4) + 0x8340
    if offset in range(0x39F88, 0x3A1EC):
        kanji_offset = (offset - 0x39F88) // 4
        file.seek(0x3A1EC + kanji_offset * 2)  # valid kanji table
        return int.from_bytes(file.read(2), "little")
    return -1
        
def dump_glyphs(file, base, quantity):
    glyphs = list()
    for i in range(quantity):
        tbl_offset = base + i*4
        code = tbl_offset_to_char_code(file, tbl_offset) # careful, changes file pointer
        file.seek(tbl_offset)
        off = int.from_bytes(file.read(4), "little")
        if off < 0x800000:
            file.seek(off + 0x284F70)
            glyph = Char(file, code=code, tbl_offset=tbl_offset)
            glyphs.append(glyph)
    return glyphs
    
def process_all_altfont_glyphs():
    '''Goal is to extract the relevant (alphanumeric + punctuation + circle numbers) glyphs from the vanilla ROM, then spit out a buncha binary files with the normalized glyphs that I can re-insert into the patched ROM via a .asm file'''
    with open(path_to_rom, "rb") as file:
        glyphs = list()
        glyphs += dump_glyphs(file, 0x39808, 192+95) #192+192+96+153 gets all chars):, 192+95 gets all punctuation + english text only
        glyphs += dump_glyphs(file, 0x39F88, 11) # nab the numbers in circles
    
    glyphs = [g for g in glyphs if g.obj_count != 0] # some obj data references no tiles...
    
    # Can mutate glyphs in here if need be...
    for g in glyphs:
        if g.char_code in range(0x824F, 0x8259):
            g.polarize_image() # digits 0-9, turn grey pixels transparent (makes them look better in intro cutscene)
        elif g.char_code == 0x814C: # fix apostrophe
            pix = g.img.load()
            pix[0, 0] = 15
            pix[1, 0] = 15
            pix[0, 1] = 0
            pix[1, 1] = 15
            pix[0, 2] = 15
        elif g.char_code == 0x8144: # adjust period width
            g.char_width = 3
    
    incbins = list()
    repoints = list()
    widths = list()
    for g in glyphs:
        g.normalize_image()
        g.format()
        incbins.append(g.get_incbin_asm())
        repoints.append(g.get_repoint_asm())
        widths.append(f"0x{g.char_width + 1:02X}, {bs}")
        
    outfile = "glyphbinaries.asm"
    
    with open(outfile, "w") as file:
        file.write("; This file was auto-generated by txt.py\n")
        file.write("; Check out the reserve folder to see corresponding glyph images!\n")
        file.write( \
f""".macro universal_glyph_header
    .byte 0x01,0x60,0x08,0x08, {bs}
          0x00,0xF9,0x22,0x04
.endmacro
""")
        file.write("\n.org 0x8039808 ; space character\n    .word @glyph_space - 0x08284F70\n")
        file.write("\n".join(repoints))

        file.write("\n\n.org 0x082E4EB4")
        file.write("\n.region 0x082FB354 - .")
        file.write("\n    @glyph_space:\n        .byte 0x00,0x70,0x08,0x08,0x01,0x60,0x08,0x08\n    .fill 0x80\n")
        file.write("\n".join(incbins))
        
        file.write("\n\nNewWidthTable:\n")
        file.write(".byte 0x04, \\\n")
        file.write("\n".join(widths))
        file.write("\n0x00") # just so every width can end in a backslash
        file.write("\n.endregion")
        
    print(f"wrote {outfile}")


def main():
    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)
        
    process_all_altfont_glyphs() 

if __name__ == "__main__":
    main()