
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
    .incbin "bin/asciiwidthtable.bin"
    
.org WRAMToROM(02031952h)
    nop ; just a hack to make lowercase ASCII refer to different object tiles, originally: subs r4, 020h

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

; ~256 bytes of free space at the end of the payload
; The lowercase ASCII letters aren't set to the child GBAs -_-
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