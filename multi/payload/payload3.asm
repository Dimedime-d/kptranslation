.gba
.open "build/multipayload3.bin", 0x00 ; this payload exists for a very short time, just use offset 0x00

.org 0x2238
@Start:
.incbin "bin/mpObjTilesComp2.bin"
@End:

.org 0x2FC
.hword @End - @Start

.close