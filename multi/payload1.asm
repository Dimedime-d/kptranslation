.gba
.open "build/multipayload1.bin", 0x02000000 ; This is where the payload is loaded in RAM

.include "graphics/menu/menumacros.asm"

.org 0x0201FC6A
.area 0x0201FF4A-. ; overflow protection
    menu_button_128x16_header_compressed
    .incbin "graphics/menu/dumps/MultiFreePlay.dmp"
    .word 0x00000000
    .align
.endarea

.org 0x0201FF4A
.area 0x0202023D-.
    menu_button_128x16_header_compressed
    .incbin "graphics/menu/dumps/MultiRoundLimit.dmp"
    .word 0x00000000
    .align
.endarea

.org 0x0202023D
.area 0x02020530-.
    menu_button_128x16_header_compressed
    .incbin "graphics/menu/dumps/MultiTimeLimit.dmp"
    .word 0x00000000
    .align
.endarea

.org 0x02020530
.area 0x0202088D-.
    .byte 0x05,0x80,0x48,0x08
    menu_button_160x16_header_partial
    .incbin "graphics/menu/dumps/1P2PKurukuruKururin.dmp"
    .word 0x00000000
    .align
.endarea

.org 0x0202088D
.area 0x02020BEB-.
    .byte 0x05,0x80,0x48,0x08
    menu_button_160x16_header_partial
    .incbin "graphics/menu/dumps/1P3PKurukuruKururin.dmp"
    .word 0x00000000
    .align
.endarea

.org 0x02020BEB
.area 0x02020F3F-.
    .byte 0x05,0x80,0x48,0x08
    menu_button_160x16_header_partial
    .incbin "graphics/menu/dumps/1P4PKurukuruKururin.dmp"
    .word 0x00000000
    .align
.endarea

.close