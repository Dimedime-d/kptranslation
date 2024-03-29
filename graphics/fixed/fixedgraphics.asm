; This file was automatically generated by formatfixed.py
    
.macro demoheader ; source: 0x08287244
	.byte   0x02,0x70,0x1C,0x08, \
            0xE4,0xF9,0x24,0x08, \
            0x04,0xF9,0x24,0x08
.endmacro    

.macro replayheader ; source: 0x08287450
    .byte   0x02,0x70,0x1C,0x08, \
            0xE4,0xF9,0x24,0x08, \
            0x04,0xF9,0x24,0x08  ; normalize y-position
.endmacro

.macro keygetheader ; source: 0x0829CEAC
    .byte   0x06,0x70,0x28,0x30, \
            0xD8,0xD0,0x44,0x10, \
            0xF8,0xD0,0x44,0x10, \
            0x18,0xD0,0x44,0x10, \
            0xD8,0xEF,0x14,0x04, \
            0xF8,0xEF,0x14,0x04, \
            0x18,0xEF,0x14,0x04
.endmacro

.macro norecordheader ; source: 0x0829BBC0
    .byte   0x0A,0x00,0x78,0x50, \
            0x89,0xB1,0x44,0x10, \
            0xA9,0xB1,0x44,0x10, \
            0xC9,0xB1,0x44,0x10, \
            0xE9,0xB1,0x44,0x10, \
            0x09,0xB1,0x41,0x04, \
            0x89,0xD0,0x14,0x04, \
            0xA9,0xD0,0x14,0x04, \
            0xC9,0xD0,0x14,0x04, \
            0xE9,0xD0,0x14,0x04, \
            0x09,0xD0,0x11,0x01
.endmacro

.org 0x08287244
.area 0x08287450 - org()
    demoheader
    .incbin "graphics\fixed\dumps\demo.dmp"
.endarea

.org 0x08287450
.area 0x0828765C - org()
    replayheader
    .incbin "graphics\fixed\dumps\replay.dmp"
.endarea

.org 0x0829BBC0
.area 0x0829C68C - org()
    norecordheader
    .incbin "graphics\fixed\dumps\no_record.dmp"
.endarea

.org 0x0829CEAC
.area 0x0829D688 - org()
    keygetheader
    .incbin "graphics\fixed\dumps\key_get.dmp"
.endarea

; just write a new palette for no record because grit fucked up
.org 0x081C3BD0
.area 0x20
    .incbin "graphics\fixed\dumps\no_record,0.pal.bin"
.endarea

.org 0x0819C2A4
.area 0x20
    .incbin "graphics\fixed\dumps\key_get,0.pal.bin"
.endarea
