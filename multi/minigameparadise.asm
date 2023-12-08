
; the payload here is located at 6B4390 in ROM, moved to 02028000 uncompressed in WRAM to the child GBAs

.expfunc WRAMToROM(n), n - 02028000h + 086B4390h ; my notes have graphics pointers as the WRAM ones
.expfunc ROMToWRAM(n), n - 086B4390h + 02028000h

.org  WRAMToROM(0203EBC0h)
.area WRAMToROM(0203EEA0h)-.
    menu_button_128x16_header_compressed
    .incbin "graphics/menu/dumps/MultiFreePlay.dmp"
    .word 0x00000000
    .align
.endarea

.org  WRAMToROM(0203EEA0h)
.area WRAMToROM(0203F193h)-.
    menu_button_128x16_header_compressed
    .incbin "graphics/menu/dumps/MultiRoundLimit.dmp"
    .word 0x00000000
    .align
.endarea

.org  WRAMToROM(0203F193h)
.area WRAMToROM(0203F486h)-.
    menu_button_128x16_header_compressed
    .incbin "graphics/menu/dumps/MultiTimeLimit.dmp"
    .word 0x00000000
    .align
.endarea

.org  WRAMToROM(0203F486h)
.area WRAMToROM(0203F7E5h)-.
    .byte 0x05,0x80,0x48,0x08
    menu_button_160x16_header_partial
    .incbin "graphics/menu/dumps/1P2PMinigameParadise.dmp"
    .word 0x00000000
    .align
.endarea

.org  WRAMToROM(0203F7E5h)
.area WRAMToROM(0203FB45h)-.
    .byte 0x05,0x80,0x48,0x08
    menu_button_160x16_header_partial
    .incbin "graphics/menu/dumps/1P3PMinigameParadise.dmp"
    .word 0x00000000
    .align
.endarea

.org  WRAMToROM(0203FB45h)
.area WRAMToROM(0203FEE0h)-.
    .byte 0x05,0x80,0x48,0x08
    menu_button_160x16_header_partial
    .incbin "graphics/menu/dumps/1P4PMinigameParadise.dmp"
    .word 0x00000000
    .align
.endarea

; same ascii width table as in single player
.org 0x086C9054
    .incbin "bin/asciiwidthtable2.bin"
    
.org WRAMToROM(02031952h)
    nop ; just a hack to make lowercase ASCII refer to different object tiles, originally: subs r4, 020h

.org WRAMToROM(0203DA84h)
    .area WRAMToROM(0203E030h)-., 0x00
        .incbin "bin/mpObjTilesComp.bin"
    .endarea
    .area WRAMToROM(0203E3F2h)-.,0x00
        .incbin "graphics/menu/dumps/bubblenums.dmp" ; actually change "rounds" and "minutes" display
    .endarea

; Minigame Titles
.org 0x086B9DA0
    .word ROMToWRAM(@Random)   
    .word ROMToWRAM(@ChuChuPanic)  
    .word ROMToWRAM(@Crossfire)
    .word ROMToWRAM(@StarlightRomance) 
    .word ROMToWRAM(@SuperJumper)   
    .word ROMToWRAM(@SmashForce)
    .word ROMToWRAM(@DotFiller)   
    .word ROMToWRAM(@GrassCutter)  
    .word ROMToWRAM(@SlipDrop)
    .word ROMToWRAM(@InTheSky)  
    .word ROMToWRAM(@QuickFlip) 
    .word ROMToWRAM(@LoveAttack)
    .word ROMToWRAM(@FallingDown)  
    .word ROMToWRAM(@MagnetForce)   
    .word ROMToWRAM(@PitPuttRacer)
    .word ROMToWRAM(@SpinShot)  
    .word ROMToWRAM(@TwinHopper)
    
; information when starting up
.org WRAMToROM(0202DA68h)
    .word ROMToWRAM(@YouAreP1)
    .word ROMToWRAM(@YouAreP2)
    .word ROMToWRAM(@YouAreP3)
    .word ROMToWRAM(@YouAreP4)
    .word ROMToWRAM(@MP1P)
    .word ROMToWRAM(@MP1P)
    .word ROMToWRAM(@MP2P)
    .word ROMToWRAM(@MP3P)
    .word ROMToWRAM(@MP4P)
    .word ROMToWRAM(@Info1)
    .word ROMToWRAM(@Info2)

.org WRAMToROM(0202B380h)   ; Wobbly text is unfortunately broken, the English ASCII characters aren't in the right spots...
    .word ROMToWRAM(@MPInfo)    
.org WRAMToROM(0202B60Ch)
    .word ROMToWRAM(@MPInfo)

.org WRAMToROM(0202C146h)
    mov r0, 0x60 ; center "Continue"

.org WRAMToROM(0202C14Ch)
    .word ROMToWRAM(@Continue)
    
.org WRAMToROM(0202C16Ch)
    .word ROMToWRAM(@Stop)

; New strings should be in free space...

; ~256 bytes of free space at the end of the payload
; The lowercase ASCII letters aren't set to the child GBAs... so force them to be sent and do some OAM magic
.org 0x086CC280
    .area 0x100
    @Random:            .asciiz "Random"            ::  .align
    @ChuChuPanic:       .asciiz "Chu-Chu Panic"     ::  .align
    @SmashForce:        .asciiz "Smash Force"       ::  .align
    @QuickFlip:         .asciiz "Quick Flip"        ::  .align
    @LoveAttack:        .asciiz "Love Attack"       ::  .align
    @InTheSky:          .asciiz "In The Sky"        ::  .align
    @SpinShot:          .asciiz "Spin Shot"         ::  .align
    @TwinHopper:        .asciiz "Twin Hopper"       ::  .align
    @SuperJumper:       .asciiz "Super Jumper"      ::  .align
    @FallingDown:       .asciiz "Falling Down"      ::  .align
    @GrassCutter:       .asciiz "Grass Cutter"      ::  .align
    @StarlightRomance:  .asciiz "Starlight Romance" ::  .align
    @PitPuttRacer:      .asciiz "Pit-Putt Racer"    ::  .align
    @DotFiller:         .asciiz "Dot Filler"        ::  .align
    @SlipDrop:          .asciiz "Slip Drop"         ::  .align
    @MagnetForce:       .asciiz "Magnet Force"      ::  .align
    @Crossfire:         .asciiz "Crossfire"         ::  .align
.endarea

; original space taken by the Japanese minigame titles
.org WRAMToROM(0202D720h)
    .area 0xD0
    @MP1P:              .asciiz "Minigame Paradise" ::  .align
    @MP2P:              .asciiz "2P Minigame Paradise" ::   .align
    @MP3P:              .asciiz "3P Minigame Paradise" ::   .align
    @MP4P:              .asciiz "4P Minigame Paradise" ::   .align
    @MPInfo:            .asciiz "waiting for host"     ::   .align
    @YouAreP1:          .asciiz "You are Player 1"  ::      .align
    @YouAreP2:          .asciiz "You are Player 2"  ::      .align
    @YouAreP3:          .asciiz "You are Player 3"  ::      .align
    @YouAreP4:          .asciiz "You are Player 4"  ::      .align
.endarea

; space taken up by Japanese text on black screen
.org WRAMToROM(0202D838h)
    .area 0xD0
    @Info1:             .asciiz "To play 'Kurukuru Kururin'"   ::  .align
    @Info2:             .asciiz "Reset and reconnect your systems"  ::  .align
    @Continue:          .asciiz "Continue"  ::  .align
    @Stop:              .asciiz "Stop"      ::  .align
.endarea

; results podium
.org 0x08792840+4
    .byte 0xFD,0xEE,0x11,0x04 ; shift right by 7 px (originally F6), object size down to 8x8 from 32x8
.org 0x0879287A+4
    .byte 0xFC,0x0E,0x11,0x04 ; shift right by 7 px (originally F6), object size down to 8x8 from 32x8
.org 0x087928C4+4
    .byte 0xFC,0x1E,0x11,0x04 ; shift right by 7 px (originally F6), object size down to 8x8 from 32x8
.org 0x08792911+4
    .byte 0xFC,0x2E,0x11,0x04 ; shift right by 7 px (originally F6), object size down to 8x8 from 32x8
