import struct

with open("titleBG1Map.dmp", "rb") as file:
    a = struct.unpack('<'+'H'*(0x4B0//2), file.read(0x4B0))
    
b = []
for i in a:
    if (i & 0x1FF) > 0:
        b.append(i + (0x200 - 0x188)) # leaving extra room in VRAM for custom title screen, incrementing the tile indexes from the original map
    else:
        b.append(i)

with open("titleBG1MapFix.dmp", "wb") as file:
    file.write(struct.pack('<'+'H'*(0x4B0//2), *b))