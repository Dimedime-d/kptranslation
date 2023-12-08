# GUI Program to draw pre-rendered text in Magic instructions

import tkinter as tk
from tkinter import ttk
from tkinter import scrolledtext
from tkinter.filedialog import asksaveasfilename
from PIL import Image, ImageTk, ImageGrab
import os
import glyphs

import sys
sys.path.append("..")
from compression import LZ

TEMP_FOLDER = "reserve"
DUMP_FOLDER = "dumps"
bw = 4 # borderwidth
CV_WIDTH = 240
CV_HEIGHT = 160

class OOP:
    # dumped from 0x1D6570
    text_palette = [248, 240, 160, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 248, 240, 160, 216, 192, 120, 184, 152, 80, 152, 104, 40, 128, 64, 0]
    
    def __init__(self):
        self.saving = False
        self.win = tk.Tk()
        self.win.title("Python GUI")
        self.win.resizable(0,0)
        self.create_widgets()
        
        
    def create_widgets(self):
        text_frame = ttk.LabelFrame(self.win, text=" Type here")
        text_frame.grid(column=0, row=0, padx=8, pady=0)
        self.scr = scrolledtext.ScrolledText(text_frame, width=50, height=5)
        self.scr.grid(column=0, row=0, columnspan=20, sticky="SW")
        self.scr.bind("<KeyRelease>", self.update_image)
        
        vcmd = text_frame.register(self.validateNum, "%P")
    
        # Entry Fields
        x_label = ttk.Label(text_frame, text="X")
        x_label.grid(column=0, row=1)
        self.x_coord = tk.IntVar()
        self.x_field = ttk.Entry(text_frame, width=4, textvariable=self.x_coord, validate="key", validatecommand=vcmd)
        self.x_field.grid(column=0, row=2)
        self.x_field.bind("<KeyRelease>", self.update_image)
        self.x_coord.set(15)
        
        y_label = ttk.Label(text_frame, text="Y")
        y_label.grid(column=1, row=1)
        self.y_coord = tk.IntVar()
        y_field = ttk.Entry(text_frame, width=4, textvariable=self.y_coord, validate="key", validatecommand=vcmd)
        y_field.grid(column=1, row=2)
        y_field.bind("<KeyRelease>", self.update_image)
        self.y_coord.set(60)
        
        spacing_label = ttk.Label(text_frame, text="Spacing")
        spacing_label.grid(column=0, row=3)
        self.spacing = tk.IntVar()
        self.spacing_field = ttk.Entry(text_frame, width=4, textvariable=self.spacing, validate="key", validatecommand=vcmd)
        self.spacing_field.grid(column=0, row=4)
        self.spacing_field.bind("<KeyRelease>", self.update_image)
        self.spacing.set(14)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        self.overlay = tk.IntVar(value = 1)
        overlay_checkbox = ttk.Checkbutton(text_frame, text="Background?", variable=self.overlay, command=self.update_image)
        overlay_checkbox.grid(column=4, row=1, rowspan=2, sticky="NSWE")
        self.overlay_img = Image.open("background.bmp").convert("RGBA")
        
        self.illustration = tk.IntVar(value = 0)
        illustration_checkbox = ttk.Checkbutton(text_frame, text="Picture?", variable=self.illustration, command=self.update_image)
        illustration_checkbox.grid(column=4, row=3, rowspan=2, sticky="NSWE")
        self.illustration_pic = Image.open("image.png").convert("RGBA")
        
        save_button = ttk.Button(text_frame, text="Save", command=self.save_image)
        save_button.grid(column=5, row=1, rowspan=2, sticky="NSWE")
       
        # Canvas
        canvasFrame = ttk.LabelFrame(self.win, text="Text Display", relief=tk.GROOVE, borderwidth=bw)
        canvasFrame.grid(column=1, row=0)
        self.cv = tk.Canvas(canvasFrame, width=250, height=170)
        self.cv.grid(column=0, row=0)
        self.img = Image.new("RGB", (CV_WIDTH, CV_HEIGHT))
        self.set_image()
        self.update_image()
        
    def set_image(self):
        self.photo_img = ImageTk.PhotoImage(self.img)
        self.cv.create_image(0, 0, anchor="nw", image=self.photo_img)
        
    def save_image(self):
        self.saving = True
        self.update_image()
        files = [("Portable Network Graphics (*.png)", "*.png")]
        filename = asksaveasfilename(filetypes=files, defaultextension=files)
        self.requantized_image = self.quantize_to_palette(self.img, self.text_palette)
        self.saving = False
        self.update_image()
        try:
            self.requantized_image.save(filename, "PNG")
            msg_answer = tk.messagebox.askyesno(title = "grit format?", message = f"Format with grit to a .dmp file?")
            if msg_answer:
                self.image_to_dmp(filename)
        except FileNotFoundError:
            print("Couldn't save!")
            
    @staticmethod
    def quantize_to_palette(img, palette):
        palImage = Image.new("P", (1,1))
        palImage.putpalette(palette + [0, 0, 0] * 240)
        return img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)
        
    @staticmethod
    def image_to_dmp(img_file):
        # absolute file path
        out_file = f"{os.path.join(TEMP_FOLDER, f'{os.path.basename(img_file[:-4])}')}"
        # the file that grit will spit out
        
        # in order: no palette (we already requantized), 4bpp, transparent color, pixel offset 11 (0x0B) for non-transparent pixels, force palette-bank index to 3 (-mp3 forces tilemap file to be formed), 1x1 metatiles, .bin file, no header, output file
        os.system(f"cmd /c ..\\.\\grit {img_file} -p! -gB4 -gt -ga11, -mp3 -Mh1 -Mw1 -ftb -fh! -o {out_file}")
        out_tileset_file = f"{out_file}.img.bin"
        out_tilemap_file = f"{out_file}.map.bin"
        
        set_dmp_file = os.path.join(DUMP_FOLDER, f"{os.path.basename(img_file[:-4])}.set.dmp")
        map_dmp_file = os.path.join(DUMP_FOLDER, f"{os.path.basename(img_file[:-4])}.map.dmp")
        with open(out_tileset_file, "rb") as set_bin, open(out_tilemap_file, "rb") as map_bin:
            set_bytes, map_bytes = LZ.compress(set_bin.read()), LZ.compress(map_bin.read())
            
        # Manipulate data here, if needed
        
        with open(set_dmp_file, "wb") as set_dmp, open(map_dmp_file, "wb") as map_dmp:
            set_dmp.write(set_bytes)
            map_dmp.write(map_bytes)
            print(f"wrote {set_dmp.name} and {map_dmp.name}")
            
    def validateNum(self, P):
        return P.isnumeric() and len(P) <= 3
        
    def update_image(self, *event):
        self.clear_image() # Wipe
        self.img.paste((248, 240, 160), (0, 0, self.img.size[0], self.img.size[1]))
        if self.overlay.get() and not self.saving:
            self.img.paste(self.overlay_img, (0, 0), self.overlay_img)
        if self.illustration.get() and not self.saving:
            self.img.paste(self.illustration_pic, (137, 59), self.illustration_pic)
        
        self.text = self.scr.get(1.0, "end-1c")
        self.draw_chars_to_image(self.text)
        self.set_image()
        
    def clear_image(self):
        self.img = Image.new("RGB", (CV_WIDTH, CV_HEIGHT))
        self.set_image()
    
    def draw_chars_to_image(self, text):
        textX, textY = self.x_coord.get(), self.y_coord.get()
        for line in text.split("\n"):
            for c in line:
                char_img = glyphs.char_map.get(c, glyphs.char_map[" "]).img
                char_y_off = glyphs.char_map.get(c, glyphs.char_map[" "]).yOffset
                
                if (0 <= textX <= CV_WIDTH) and (0 <= textY <= CV_HEIGHT):
                    self.img.paste(char_img, (textX, textY+char_y_off), char_img)
                    
                textX += char_img.width + 1
            textY += self.spacing.get()
            textX = self.x_coord.get()
            
def main():
    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)
    oop = OOP()
    oop.win.mainloop()

if __name__ == "__main__":
    main()