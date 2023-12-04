; for inserting payloads into the ROM, or modifying necessary sections if they happen to be uncompressed

.org 0x0868C57C
.area 0x086B4390-. ; slightly smaller than 0x28000 bytes, because it bleeds into the minigame paradise payload
    .incbin "build/multipayload1.bin"
.endarea

.include "multi/minigameparadise.asm"