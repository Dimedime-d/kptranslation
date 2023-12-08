; for inserting payloads into the ROM, or modifying necessary sections if they happen to be uncompressed

; kurukuru kururin payloads
.org 0x0868C57C
.area 0x086B4390-. ; slightly smaller than 0x28000 bytes, because it bleeds into the minigame paradise payload
    .incbin "build/multipayload1.bin"
.endarea

.org 0x08688660
.area 0x0868C57C-.
    .incbin "build/multipayload2.bin"
.endarea

.org 0x086B18A4
.area 0x086B5774-.
    .incbin "build/multipayload3.bin"
.endarea

; the main minigame paradise payload is uncompressed
.include "multi/minigameparadise.asm"