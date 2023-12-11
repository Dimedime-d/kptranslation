; customcode.asm now pulls from the labels here.

@MagicLearn equ "graphics\learnmagic\dumps\\"

.macro ImageObjHeader,palette
    .byte   0x09,palette,0x2C,0x2C, \
            0xD4,0xD4,0x44,0x10, \
            0xF4,0xD4,0x44,0x10, \
            0x14,0xD4,0x44,0x10, \
            0xD4,0xF4,0x44,0x10, \
            0xF4,0xF4,0x44,0x10, \
            0x14,0xF4,0x44,0x10, \
            0xD4,0x14,0x44,0x10, \
            0xF4,0x14,0x44,0x10, \
            0x14,0x14,0x44,0x10 
.endmacro

.autoregion
    .align
    TableMagicInstructions:
        .word @KururinShockInstructions
        
    
    @KururinShockInstructions:
        .word @KururinShockStep1Set
        .word @KururinShockStep1Map
        .word @KururinShockStep2Set
        .word @KururinShockStep2Map
        .word @KururinShockStep3Set
        .word @KururinShockStep3Map
        .word @KururinShockStep4Set
        .word @KururinShockStep4Map
        .word @KururinShockStep5Set
        .word @KururinShockStep5Map
        .word @KururinShockStep6Set
        .word @KururinShockStep6Map
        .word @KururinShockStep7Set
        .word @KururinShockStep7Map
        .word 0x00
        
    @KururinShockStep1Set:  ::  .incbin @MagicLearn + "1,1.set.dmp" ::  .align
    @KururinShockStep1Map:  ::  .incbin @MagicLearn + "1,1.map.dmp" ::  .align
    @KururinShockStep2Set:  ::  .incbin @MagicLearn + "1,2.set.dmp" ::  .align
    @KururinShockStep2Map:  ::  .incbin @MagicLearn + "1,2.map.dmp" ::  .align
    @KururinShockStep3Set:  ::  .incbin @MagicLearn + "1,3.set.dmp" ::  .align
    @KururinShockStep3Map:  ::  .incbin @MagicLearn + "1,3.map.dmp" ::  .align
    @KururinShockStep4Set:  ::  .incbin @MagicLearn + "1,4.set.dmp" ::  .align
    @KururinShockStep4Map:  ::  .incbin @MagicLearn + "1,4.map.dmp" ::  .align
    @KururinShockStep5Set:  ::  .incbin @MagicLearn + "1,5.set.dmp" ::  .align
    @KururinShockStep5Map:  ::  .incbin @MagicLearn + "1,5.map.dmp" ::  .align
    @KururinShockStep6Set:  ::  .incbin @MagicLearn + "1,6.set.dmp" ::  .align
    @KururinShockStep6Map:  ::  .incbin @MagicLearn + "1,6.map.dmp" ::  .align
    @KururinShockStep7Set:  ::  .incbin @MagicLearn + "1,7.set.dmp" ::  .align
    @KururinShockStep7Map:  ::  .incbin @MagicLearn + "1,7.map.dmp" ::  .align

    TableMagicImages:
        .word @KururinShockImages
        
    @Terminator equ 0xFF, 0xFF

    ; bytes are page number (0-indexed) and image ID
    @KururinShockImages:
        .byte 0x02, 0x00, @Terminator
        
    .align
    @Picture0:
        ImageObjHeader 0x01
        .incbin @MagicLearn + "pic0.dmp"
        
    ObjLArrow:
        .byte   0x01,0x0B,0x10,0x08, \
                0xF3,0xF8,0x24,0x08
        .incbin "bin/obj_LArrow.bin"
    ObjRArrow:
        .byte   0x01,0x0B,0x10,0x08, \
                0xF8,0xF8,0x24,0x08
        .incbin "bin/obj_RArrow.bin"
        
    .align
    
    @Preview0Tiles:
        .incbin @MagicLearn + "preview0tiles.dmp" ::    .align
    @Preview0Map:
        .incbin @MagicLearn + "preview0map.dmp"   ::    .align
    
.endautoregion

; repointing picture data
.org 0x0803C1FC
    .word @Picture0 ; Kururin Shock - GBA with ticker
    
; repointing preview data
.org 0x0803C0BC
    .word @Preview0Tiles
    .word @Preview0Map
    .skip 4 ; palette unchanged
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    