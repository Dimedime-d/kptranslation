.byte 0x02,0x00,0x09,0x00
.word 0x08095838
.byte 0x09,0x00,0x0F,0x00
.byte 0x02,0x00,0x00,0x00
.byte 0x00,0x01,0x00,0x00
.byte 0x00,0x1E,0x00,0x03
.byte 0x09,0x00,0x00,0x00
.byte 0x02,0x00,0x00,0x00
.byte 0xCC,0x14,0x0A,0x00
.byte 0xA2,0x36,0x00,0x00
.byte 0x09,0x00,0x01,0x00
.byte 0x02,0x00,0x00,0x00
.byte 0x70,0x4B,0x0A,0x00
.byte 0xB0,0x04,0x00,0x00
.byte 0x09,0x00,0x02,0x00
.byte 0x02,0x00,0x00,0x00
.byte 0x20,0x50,0x0A,0x00
.byte 0xF0,0x00,0x00,0x00
.byte 0x00,0x00,0x00,0x00

.byte 0x02,0x00,0x09,0x00
.word commonTeacherHareRankUpScript

; The original game stores copies of each rank up cutscene's dialogue for each background (village, flower, clock, magic)
; making this point to the first script for optimization