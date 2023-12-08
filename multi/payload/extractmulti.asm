.gba

.open "build/multipayload1.bin", 0x00
.incbin "kp.gba", 0x68c57c, 0x28000
.close

.open "build/multipayload2.bin", 0x00
.incbin "kp.gba", 0x688660, 0x3F20
.close

.open "build/multipayload3.bin", 0x00
.incbin "kp.gba", 0x6B18A4, 0x3ED0

.close