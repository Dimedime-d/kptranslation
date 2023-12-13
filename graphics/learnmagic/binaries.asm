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
        
    @Header0Tiles:
        .incbin @MagicLearn + "header0tiles.dmp"    ::  .align
    @Header0Map:
        .incbin @MagicLearn + "header0map.dmp"      ::  .align        
    @Header1Tiles:
        .incbin @MagicLearn + "header1tiles.dmp"    ::  .align
    @Header1Map:
        .incbin @MagicLearn + "header1map.dmp"      ::  .align        
    @Header2Tiles:
        .incbin @MagicLearn + "header2tiles.dmp"    ::  .align
    @Header2Map:
        .incbin @MagicLearn + "header2map.dmp"      ::  .align        
    @Header3Tiles:
        .incbin @MagicLearn + "header3tiles.dmp"    ::  .align
    @Header3Map:
        .incbin @MagicLearn + "header3map.dmp"      ::  .align        
    @Header4Tiles:
        .incbin @MagicLearn + "header4tiles.dmp"    ::  .align
    @Header4Map:
        .incbin @MagicLearn + "header4map.dmp"      ::  .align        
    @Header5Tiles:
        .incbin @MagicLearn + "header5tiles.dmp"    ::  .align
    @Header5Map:
        .incbin @MagicLearn + "header5map.dmp"      ::  .align        
    @Header6Tiles:
        .incbin @MagicLearn + "header6tiles.dmp"    ::  .align
    @Header6Map:
        .incbin @MagicLearn + "header6map.dmp"      ::  .align        
    @Header7Tiles:
        .incbin @MagicLearn + "header7tiles.dmp"    ::  .align
    @Header7Map:
        .incbin @MagicLearn + "header7map.dmp"      ::  .align        
    @Header8Tiles:
        .incbin @MagicLearn + "header8tiles.dmp"    ::  .align
    @Header8Map:
        .incbin @MagicLearn + "header8map.dmp"      ::  .align        
    @Header9Tiles:
        .incbin @MagicLearn + "header9tiles.dmp"    ::  .align
    @Header9Map:
        .incbin @MagicLearn + "header9map.dmp"      ::  .align        
    @Header10Tiles:
        .incbin @MagicLearn + "header10tiles.dmp"    ::  .align
    @Header10Map:
        .incbin @MagicLearn + "header10map.dmp"      ::  .align        
    @Header11Tiles:
        .incbin @MagicLearn + "header11tiles.dmp"    ::  .align
    @Header11Map:
        .incbin @MagicLearn + "header11map.dmp"      ::  .align        
    @Header12Tiles:
        .incbin @MagicLearn + "header12tiles.dmp"    ::  .align
    @Header12Map:
        .incbin @MagicLearn + "header12map.dmp"      ::  .align        
    @Header13Tiles:
        .incbin @MagicLearn + "header13tiles.dmp"    ::  .align
    @Header13Map:
        .incbin @MagicLearn + "header13map.dmp"      ::  .align        
    @Header14Tiles:
        .incbin @MagicLearn + "header14tiles.dmp"    ::  .align
    @Header14Map:
        .incbin @MagicLearn + "header14map.dmp"      ::  .align        
    @Header15Tiles:
        .incbin @MagicLearn + "header15tiles.dmp"    ::  .align
    @Header15Map:
        .incbin @MagicLearn + "header15map.dmp"      ::  .align
        
    ; this table is NOT in the original ROM (the headers used to be all 1 tileset), so it must be in the autoregion as a global variable
    
    MagicHeaderTable:
        .word @Header0Tiles
        .word @Header0Map
        .word @Header1Tiles
        .word @Header1Map
        .word @Header2Tiles
        .word @Header2Map
        .word @Header3Tiles
        .word @Header3Map
        .word @Header4Tiles
        .word @Header4Map
        .word @Header5Tiles
        .word @Header5Map
        .word @Header6Tiles
        .word @Header6Map
        .word @Header7Tiles
        .word @Header7Map
        .word @Header8Tiles
        .word @Header8Map
        .word @Header9Tiles
        .word @Header9Map
        .word @Header10Tiles
        .word @Header10Map
        .word @Header11Tiles
        .word @Header11Map
        .word @Header12Tiles
        .word @Header12Map
        .word @Header13Tiles
        .word @Header13Map
        .word @Header14Tiles
        .word @Header14Map
        .word @Header15Tiles
        .word @Header15Map
    
    .align
    
    @TrickTenHundredObj: ; juuust too big to fit in original space (7AB35C -> 7AC390), unfortunately
        .incbin "bin/tenhundredobjnew.bin"
        
    .align
    
    @TrickTimeTiles: ; also just too big (7AE184 -> 7AE84C)
        .incbin "bin/timenewtiles.bin"
    
.endautoregion

; repointing picture data
.org 0x0803C1FC
    .word @Picture0 ; Kururin Shock - GBA with ticker
    
; repointing preview data
.org 0x0803C0BC
    .word @Preview0Tiles
    .word @Preview0Map
    .skip 4 ; palette unchanged
    
;===========Misc. Magic tricks==============

.org 0x0879EE58
    .word @TrickTenHundredObj
    
.org 0x087AAEB4
.area 0x087AB35C-.
    .incbin @MagicLearn + "tenhundredtiles.dmp"
.endarea
    
.org 0x087AC4F8
.area 0x087AC654-.
    .incbin @MagicLearn + "tenhundredintromap.dmp"
.endarea
    
.org 0x087AC390
.area 0x087AC4F8-.
    .incbin @MagicLearn + "tenhundredcoinmap.dmp"
.endarea

; repositioning sprite text in ten and hundred
.org 0x0879F30A
    mov r2, 0x50 ; "10"/"100" text
    mov r3, 0x6A
    
.org 0x0879F364
    mov r2, 0x50
    mov r3, 0x6A
    
.org 0x0879F320
    mov r2, 0x68
    mov r3, 0x7A

.org 0x0879F348
    mov r2, 0x68
    mov r3, 0x7A
    
.org 0x0879F3A8
    mov r2, 0x68
    mov r3, 0x7A
    
.org 0x0879F37A
    mov r2, 0x68
    mov r3, 0x7A
    
.org 0x087AC718 ::  .byte 0x58
.org 0x087AC728 ::  .byte 0x5C ; I switched heads and tails lol
    
; book test
.org 0x087AC7F4
.area 0x087ACE8C-.
    .incbin "bin/booktestnewtiles.bin"
.endarea

.org 0x087AD96C
.area 0x087ADAD4-.
    .incbin @MagicLearn + "booktestmap1.dmp"
.endarea

.org 0x087ADAD4
.area 0x087ADC24-.
    .incbin @MagicLearn + "booktestmap2.dmp"
.endarea

.org 0x087ADC24
.area 0x087ADD64-.
    .incbin @MagicLearn + "booktestmap3.dmp"
.endarea

.org 0x0879FF60
    .word @TrickTimeTiles
    
.org 0x087AF140
    .incbin @MagicLearn + "timemap.dmp"
    
    
    
    
    
    
    
    
    
    
    