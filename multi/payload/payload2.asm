.gba
.open "build/multipayload2.bin", 0x00 ; this payload exists for a very short time, just use offset 0x00

.org 0x2248
@Start:
.incbin "bin/kkmultivramComp.bin"
@End:

.org 0x2FC
.hword @End - @Start

.close