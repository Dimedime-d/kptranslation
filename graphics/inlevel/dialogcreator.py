# GUI Program to make generating those dialogue boxes in levels easier

import tkinter as tk
from tkinter import ttk
from tkinter import scrolledtext
from tkinter.filedialog import asksaveasfilename
from PIL import Image, ImageTk, ImageGrab
import os

TEMP_FOLDER = "reserve"
DUMP_FOLDER = "dumps"
bw = 4 #borderwidth
CV_WIDTH = 240
CV_HEIGHT = 160

class OOP():
    # dumped from 0x1C6410
    dialogue_palette = [32, 88, 112, 0, 0, 0, 0, 0, 0, 88, 88, 88, 208, 208, 200, 136, 160, 152, 112, 216, 248, 0, 72, 128, 120, 160, 184, 248, 248, 248, 0, 0, 248, 0, 104, 176, 56, 136, 192, 120, 176, 208, 184, 208, 224, 248, 248, 248]

    def __init__(self):
        self.win = tk.Tk()
        self.win.title("Python GUI")
        self.win.resizable(0,0)
        self.create_widgets()
        self.create_char_map()
        
    def create_widgets(self):
        text_frame = ttk.LabelFrame(self.win, text=" Type here")
        text_frame.grid(column=0, row=0, padx=8, pady=0)
        self.scr = scrolledtext.ScrolledText(text_frame, width=50, height=5) #, wrap=tk.WORD)
        self.scr.grid(column=0, row=0, columnspan=20, sticky="SW")
        self.scr.bind("<KeyRelease>", self.update_image)
        
        vcmd = (text_frame.register(self.validateNum), "%P")
        
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
        self.y_coord.set(133)
        
        spacing_label = ttk.Label(text_frame, text="Spacing")
        spacing_label.grid(column=0, row=3)
        self.spacing = tk.IntVar()
        self.spacing_field = ttk.Entry(text_frame, width=4, textvariable=self.spacing, validate="key", validatecommand=vcmd)
        self.spacing_field.grid(column=0, row=4)
        self.spacing_field.bind("<KeyRelease>", self.update_image)
        self.spacing.set(14)
        
        self.centered = tk.IntVar()
        center_checkbox = ttk.Checkbutton(text_frame, text="Center X?", variable=self.centered, command=self.on_center_toggle)
        center_checkbox.grid(column=2, row=1, rowspan=2)
        
        center_label = ttk.Label(text_frame, text="Center X")
        center_label.grid(column=2, row=3)
        self.center_x_coord = tk.IntVar()
        self.center_field = ttk.Entry(text_frame, width=4, textvariable=self.center_x_coord, validate="key", validatecommand=vcmd)
        self.center_field.grid(column=2, row=4)
        self.center_field.bind("<KeyRelease>", self.update_image)
        self.center_x_coord.set(144)
        self.center_field["state"] = "disabled"
        
        self.overlay = tk.IntVar()
        overlay_checkbox = ttk.Checkbutton(text_frame, text="Dialogue Overlay?", variable=self.overlay, command=self.update_image)
        overlay_checkbox.grid(column=4, row=1, rowspan=2, sticky="NSWE")
        self.overlay_img = Image.open("res/template/dialoguebase.png").convert("RGBA")
        
        save_button = ttk.Button(text_frame, text="Save", command=self.save_image)
        save_button.grid(column=5, row=1, rowspan=2, sticky="NSWE")
        
        # Canvas
        canvasFrame = ttk.LabelFrame(self.win, text="Text Display", relief=tk.GROOVE, borderwidth=bw)
        canvasFrame.grid(column=1, row=0)
        self.cv = tk.Canvas(canvasFrame, width=250, height=170)
        self.cv.grid(column=0, row=0)
        self.img = Image.new("RGB", (CV_WIDTH, CV_HEIGHT))
        self.set_image()
        
    def set_image(self):
        self.photo_img = ImageTk.PhotoImage(self.img)
        self.cv.create_image(0, 0, anchor="nw", image=self.photo_img)
        
    def save_image(self):
        files = [("Portable Network Graphics (*.png)", "*.png")]
        filename = asksaveasfilename(filetypes=files, defaultextension=files)
        try:
            if self.overlay.get():
                self.save_dialogue_image(filename)
                return
            self.img.save(filename, "PNG")
        except FileNotFoundError:
            print("didn't save")
            
    def save_dialogue_image(self, file):
        temp_img = self.img.crop((40, 120, 232, 160)) # bounds of dialog box
        temp_img = self.quantize_to_palette(temp_img, self.dialogue_palette)
        temp_img.save(file, "PNG")
        msg_answer = tk.messagebox.askyesno(title="grit format?", message = f"Saved dialogue image {file}. \
Also format it with grit to a .dmp file?")
        if msg_answer:
            self.dialogue_image_to_dmp(file)
    
    @staticmethod
    def quantize_to_palette(img, palette, dither=Image.NONE):
        palImage = Image.new("P", (1, 1))
        palImage.putpalette(palette + [0, 0, 0] * 240)
        return img.convert("RGB").quantize(palette=palImage, dither=Image.NONE)

    @staticmethod
    def dialogue_image_to_dmp(img_file):
        # given absolute file path...
        # Dialogue box uses FOUR different box sizes, so I have to have 4 separate grit commands, then merge all the binaries together
        files = [f"{os.path.join(TEMP_FOLDER, f'{os.path.basename(img_file[:-4])},{i}')}" for i in range(2)]
        # In order: No palette, 4bpp, tile format, NO MAP,
        # metatile reduction, 1x1 metatiles, .bin file, no header, output file
        os.system(f"cmd /c ..\\grit {img_file} -p! -gB4 -gt -m! -Mh4 -Mw4 -al0 -aw192 -at0 -ah32 -ftb -fh! -o {files[0]}")
        os.system(f"cmd /c ..\\grit {img_file} -p! -gB4 -gt -m! -Mh1 -Mw4 -al0 -aw192 -at32 -ah8 -ftb -fh! -o {files[1]}")
        
        dmp_file = os.path.join(DUMP_FOLDER, f"{os.path.basename(img_file[:-4])}.dmp")
        with open(dmp_file, "wb") as file:
            for f in files:
                with open(f"{f}.img.bin", "rb") as file2:
                    file.write(file2.read())
        
        print(f"wrote {dmp_file}")
    
    def validateNum(self, P):
        return P.isnumeric() and len(P) <= 3
    
    def on_center_toggle(self):
        self.center_field['state'] = "enabled" if self.centered.get() else "disabled"
        self.x_field['state'] = "disabled" if self.centered.get() else "enabled"
        self.update_image()
    
    def create_char_map(self):
        self.char_dict = dict()
        for file in os.listdir("res/"):
            if file.endswith(".png"):
                char_img = Image.open(os.path.join("res", file)).convert("RGBA")
                char_y_off = self.determine_y_offset(file[0], char_img.height)
                self.char_dict[file[0]] = {"img" : char_img, "y_off" : char_y_off}
        for file in os.listdir("res/caps/"):
            char_img = Image.open(os.path.join("res", "caps", file)).convert("RGBA")
            char_y_off = self.determine_y_offset(file[0], char_img.height)
            self.char_dict[file[0]] = {"img" : char_img, "y_off" : char_y_off}
        for file in os.listdir("res/spec"):
            char_img = Image.open(os.path.join("res", "spec", file)).convert("RGBA")
            char = self.get_special_char(file[:-4])
            char_y_off = self.determine_y_offset(char, char_img.height)
            self.char_dict[char] = {"img" : char_img, "y_off" : char_y_off}
            
    def determine_y_offset(self, char, height):
        if (height >= 8): return -4
        match char:
            case '.' : return 2
            case ',' : return 1
            case '-' : return -1
            case ':' | ';' | '/' : return -3
            case 't' : return -4
            case '\'' | '\"' : return -6
            case _ :  return -2
            
    def get_special_char(self, name):
        match name:
            case "asterisk" : return '*';
            case "colon" : return ':';
            case "degreesign" : return '°';
            case "doublequote" : return '\"';
            case "greaterthan" : return '>';
            case "lessthan" : return '<';
            case "period" : return '.';
            case "questionmark" : return '?';
            case "space" : return ' ';
            case "forwardslash" : return '/';
            case "verticalline" : return '|';
            case '_' : return 'ƍ'; # should be unreachable
    
    def update_image(self, *event):
        self.clear_image() # Wipe previous image
        if self.overlay.get():
            self.img.paste(self.overlay_img, (0, 0), self.overlay_img)
        # self.text = self.restrict_text(self.scr.get("1.0", "end-1c"), 45, 5)
        self.text = self.scr.get("1.0", "end-1c")
        self.draw_chars_to_image(self.text)
        self.set_image()
        
    def clear_image(self):
        self.img = Image.new("RGB", (CV_WIDTH, CV_HEIGHT))
        self.set_image()
        
    def restrict_text(self, text, cols, rows):
        return "\n".join([col[:cols] for col in text.split("\n")[:rows]])
    
    def draw_chars_to_image(self, text):
        textX, textY = self.x_coord.get(), self.y_coord.get()
        for line in text.split("\n"):
            if self.centered.get():
                textX = self.get_centered_x(line)
            for c in line:
                char_img = self.char_dict.get(c, self.char_dict[" "])["img"]
                char_y_off = self.char_dict.get(c, self.char_dict[" "])["y_off"]
                
                if (0 <= textX <= CV_WIDTH) and (0 <= textY <= CV_HEIGHT):
                    self.img.paste(char_img, (textX, textY+char_y_off), char_img)
                # print(textX, textY)
                textX += char_img.width + 1
            textY += self.spacing.get()
            textX = self.x_coord.get()
        
    def get_centered_x(self, line):
        total_width = 0
        for c in line:
            char_img = self.char_dict.get(c, self.char_dict[" "])["img"]
            total_width += char_img.width + 1 # Includes space between each character
        total_width -= 1 # No space at end
        return int((self.center_x_coord.get() * 2 - total_width)/2 - 1)

# Start GUI
def main():
    if not os.path.exists(TEMP_FOLDER):
        os.makedirs(TEMP_FOLDER)
    oop = OOP()
    oop.win.mainloop()

if __name__ == "__main__":
    main()