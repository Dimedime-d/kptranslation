.gba
.open "build/multipayload1.bin", 0x02000000 ; This is where the payload is loaded in RAM

.include "graphics/menu/menumacros.asm"

; menu buttons
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

; ascii
.org 0x0200A122
    mov r0, 0x60 ; originally 0x66, centers "continue"
    
.org 0x0200E38A
    nop ; just a hack to make lowercase ASCII refer to different object tiles, originally: subs r4, 020h
    
; more assembly hacks to fix the wobbly text
.org 0x0200E43A
    b 0x0200E456
.org 0x0200E456
    add r2, 0x20

.org 0x02018C1C
    .incbin "bin/asciiwidthtable2.bin"

.org 0x0201DF80
.area 0x0201E52C-., 0x00
    .incbin "bin/kkmultivram2Comp.bin"
.endarea

; string replacing/re-pointing

.org 0x0201AFC0 ; free space
.area 0x0201BC60-.
    @NotConnected:  .asciiz "Not Connected" ::  .align
    @Connected:     .asciiz "Connected"     ::  .align
    @Searching:     .asciiz "Searching"     ::  .align
    @TransferringData:  .asciiz "Transferring data" ::  .align
    @StartingUp:    .asciiz "Starting up"   ::  .align
    @YouAreP1:      .asciiz "You are Player 1"  ::  .align
    @YouAreP2:      .asciiz "You are Player 2"  ::  .align
    @YouAreP3:      .asciiz "You are Player 3"  ::  .align
    @YouAreP4:      .asciiz "You are Player 4"  ::  .align
    @KK1P:          .asciiz "1P Kurukuru Kururin"   ::  .align
    @KK2P:          .asciiz "2P Kurukuru Kururin"   ::  .align
    @KK3P:          .asciiz "3P Kurukuru Kururin"   ::  .align
    @KK4P:          .asciiz "4P Kurukuru Kururin"   ::  .align
    @Info1:         .asciiz "To play 'Minigame Paradise'"   ::  .align
    @Info2:         .asciiz "Reset and reconnect your systems"  ::  .align
    @KKInfo:        .asciiz "waiting for host"      ::  .align
    @KKInfoAlt:     .asciiz "waiting{for{host"      ::  .align
    
    ; menu options
    @Continue:      .asciiz "Continue"  ::  .align
    @Stop:          .asciiz "Stop"      ::  .align
    
    @QuitLevel:     .asciiz "Quit Level"::  .align
    @GiveUp:        .asciiz "Give Up"   ::  .align
    @Retry:         .asciiz "Retry"     ::  .align
    @Resume:        .asciiz "Resume"  ::  .align
.endarea

; repointing
.org 0x02018848
    .word @NotConnected
    .word @Connected
    .word @Searching
    .org .+4h ;skip! (Press Start)
    .word @TransferringData
    .word @StartingUp
    .word @YouAreP1
    .word @YouAreP2
    .word @YouAreP3
    .word @YouAreP4
    .word @KK1P
    .word @KK1P
    .word @KK2P
    .word @KK3P
    .word @KK4P
    .word @Info1
    .word @Info2

.org 0x0200A128
    .word @Continue
.org 0x0200A148
    .word @Stop
.org 0x02017C38
    .word @Resume
    .word @Retry
    .word @GiveUp
    .word @QuitLevel
    
.org 0x02009318
    .word @KKInfoAlt
.org 0x020095F0
    .word @KKInfo

.close