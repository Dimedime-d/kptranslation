; for inserting COMPRESSED payloads into the ROM

.org 0x0868C57C
.area 0x28000 ; oddly enough, zeroing out this area results in a bad MultiBoot header
    .incbin "build/multipayload1.bin"
.endarea