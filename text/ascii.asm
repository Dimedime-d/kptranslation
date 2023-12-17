.org 0x080AFB18 ;new data with widths of the ascii font
    .incbin "bin/asciiwidthtable.bin"

;mirror lowercase ASCII characters to fix them in challenge pause menus
.org 0x08139D14
    .incbin "bin/lowercaseascii.bin"
    
;custom grade graphics
.org 0x08139854
    .incbin "bin/customgrade.bin"
    
;palette editing for custom grades
.org 0x08149CD8
    .byte 0x3F :: .byte 0x01
.org 0x0819C378
    .byte 0xFF :: .byte 0x02

.org 0x08280230 ;rewrite graphics in minigame pause menu
    .incbin "bin/minigamepausemenu.bin"

.org 0x08024D7D ;teacher hare
    .ascii "Hare"
    
.org 0x08024D87 ;baron magic
    .ascii "Magic"
    
.org 0x08024D91 ;kururin's dad
    .ascii "Totorin" :: .byte 0x00
    
.org 0x0803C269
    .ascii " " :: .byte 0x80 :: .byte 0x00 ;T
    .ascii " " :: .byte 0x81 :: .byte 0x00 ;B
    .ascii " " :: .byte 0x82 :: .byte 0x00 ;M
            
;---------------------------------------------
;In-game menus: 
;note: lowercase letters in challenge mode levels are broken    

;use mirrored alphabet to fix lowercase letters in challenge pause menu
.loadtable "text/challengeascii.tbl"

.org 0x08024DC0 ;Text data stored here
    .string "Retry"     ::  .align
    .string "Resume"    ::  .align
    .string "Give Up"   ::  .align
.org 0x08024DDC
    .string "See Demo"  ::  .align
.org 0x08024E00
    .string "Continue"  ::  .align
.org 0x08024DE8
    .string "Exit Demo" ::  .align
    
;repointing text
; 0x29330 - Adventure mode pause menu - Resume, Retry, See Course, Quit Level
.org 0x08029338     ::  .word @SeeCourse    ::  .word @QuitLevel
; 0x29340 - Multiplay kurukuru kururin pause menu - same as adventure, but "See Course" is replaced with "Give Up"
.org 0x0802934C     ::  .word @QuitLevel
; 0x29350 - Adventure mode death menu - Retry, See Course, Quit Level
.org 0x08029354     ::  .word @SeeCourse    :: .word @QuitLevel
; 0x2935C - Practice mode pause menu - Resume, Retry, See Demo, See Course, Quit Level
.org 0x08029368     ::  .word @SeeCourse    ::  .word @QuitLevel
; 0x29370 - Demo mode pause menu - Continue, Restart Demo, See Course, Eit Demo
.org 0x08029374     ::  .word @RestartDemo  ::  .word @SeeCourse
; 0x29380 - Demo mode goal menu - Restart Demo, See Course, Exit Demo
.org 0x08029380     ::  .word @RestartDemo  ::  .word @SeeCourse
; 0x2938C - Pratice mode goal menu - Retry, See Demo, See Course, Exit Demo
.org 0x08029394     ::  .word @SeeCourse    ::  .word @QuitLevel
; 0x2939C - Replay mode pause menu - Continue, Restart Demo, See Course, Save Password, Stop Replay
; 0x293B0 - Replay mode goal menu - Restart Demo, See Course, Save Password, Stop Replay
.org 0x080293A0     ::  .word @RestartDemo  ::  .word @SeeCourse    ::  .word @SavePassword :: \
    .word @StopReplay   ::  .word @RestartDemo  ::  .word @SeeCourse    ::  .word @SavePassword  :: \
    .word @StopReplay

.org 0x08024CE0
    .asciiz "Pokorin"   ::  .align
    .asciiz "Pikarin"   ::  .align
    .asciiz "Hoyorin"   ::  .align
    .asciiz "Fuwarin"   ::  .align
    .asciiz "Gekirin"   ::  .align
.org 0x08024D10
    .asciiz "Loverin"   ::  .align
    .asciiz "Maririn"   ::  .align
    .asciiz "Kakurin"   ::  .align
    
;more repointing
.org 0x08029098 ::  .word @Hyokorin
.org 0x080290A8 ::  .word @Chikurin ::  .word @Hyokorin
.org 0x080290D0 ::  .word @Chikurin

.org 0x0802E67C
    .word @Random   :: .word @ChuChuPanic   :: .word @Crossfire
    .word @StarlightRomance :: .word @SuperJumper   :: .word @SmashForce
    .word @DotFiller    :: .word @GrassCutter   :: .word @SlipDrop
    .word @InTheSky     :: .word @QuickFlip     :: .word @LoveAttack
    .word @FallingDown  :: .word @MagnetForce   :: .word @PitPuttRacer
    .word @SpinShot     :: .word @TwinHopper

;---------------------------------------------

;Text that doesn't fit in original space
.autoregion
    @SeeCourse:     .string "See Course"    ::  .align
    @QuitLevel:     .string "Quit Level"    ::  .align
    @RestartDemo:   .string "Restart Demo"  ::  .align
    @SavePassword:  .string "Save Password" ::  .align
    @StopReplay:    .string "Stop Replay"   ::  .align
    @Hyokorin:      .asciiz "Hyokorin"      ::  .align
    @Chikurin:      .asciiz "Chikurin"      ::  .align
    @SinglePakVersus:   .asciiz "Single Pak Versus" ::  .align
    @StartNewGame:  .asciiz "Start New Game"    ::  .align
    @FullSize:      .asciiz "Full Size"     ::  .align
    @EraseFile:     .asciiz "Erase File"        ::  .align
    @NoDataStored:  .asciiz "No Data Stored"    ::  .align
    @EraseWhichFile:    .asciiz "Erase which file?" ::  .align
    @ReallyErase:   .asciiz "Really delete this file?"  ::  .align
    @Continue:  .string "Continue"  ::  .align
    @Name0:     .asciiz "Kururin"   ::  .align
    @Name1:     .asciiz "Kurukuru"  ::  .align
    @Name2:     .asciiz "Nanashi"   ::  .align
    @Name3:     .asciiz "Dimedime"  ::  .align
    @Name4:     .asciiz "Tekitou"   ::  .align
    @Name5:     .asciiz "Guest"     ::  .align
    @Name6:     .asciiz "KuruPara"  ::  .align
    @Name7:     .asciiz "Paradise"  ::  .align
    @Learn:     .asciiz "   Learn"  ::  .align
    MiniParaTitles: .incbin "graphics/menu/dumps/minigametitles.dmp" ; ONLY for the single-player version of minigames
    ; These minigame titles are rendered in the Single Pak Versus version of Minigame Paradise
    @Random:            .asciiz "Random"            ::  .align
    @ChuChuPanic:       .asciiz "Chu-Chu Panic"     ::  .align
    @SmashForce:        .asciiz "Smash Force"       ::  .align
    @QuickFlip:         .asciiz "Quick Flip"        ::  .align
    @LoveAttack:        .asciiz "Love Attack"       ::  .align
    @InTheSky:          .asciiz "In the Sky"        ::  .align
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
    ; Magic Tricks
    @KururinShock:      .asciiz "Kururin Shock"     ::  .align
    @TenAndHundred:     .asciiz "Ten and Hundred"   ::  .align
    @BookTest:          .asciiz "Book Test"         ::  .align
    @TimeParadox:       .asciiz "Time Paradox"      ::  .align
    @SoundCatch:        .asciiz "Sound Catch"       ::  .align
    @CenterPoint:       .asciiz "Center Point"      ::  .align
    @GameBoyPanic:      .asciiz "Game Boy Panic"    ::  .align
    @Impression:        .asciiz "Impression"        ::  .align
    @Twist:             .asciiz "Twist"             ::  .align
    @Imagine:           .asciiz "Imagine"           ::  .align
    @LoveTester:        .asciiz "Love Tester"       ::  .align
    @CaliforniaFlip:    .asciiz "California Flip"   ::  .align
    @DoctorKururin:     .asciiz "Doctor Kururin"    ::  .align
    @Microwave:         .asciiz "Microwave"         ::  .align
    @UpDown:            .asciiz "Up Down"           ::  .align
    @DontTouch:          .asciiz "Don't Touch"       ::  .align
    ; Misc. Save Data
    @DeleteData1:       .asciiz "Delete ALL"        ::  .align
    @DeleteData2:       .asciiz "save data?"        ::  .align
    @DeleteDataYes:     .asciiz "Yes"               ::  .align
    @DeleteDataNo:      .asciiz "No!"               ::  .align
    @CorruptedData1:    .asciiz "The save data"     ::  .align
    @CorruptedData2:    .asciiz "is corrupted."     ::  .align
    @CorruptedData3:    .asciiz "Reinitializing data..."    ::  .align
.endautoregion
        
;---------------------------------------------
.org 0x080172FE
    bl MiniParaTitleHook
.org 0x08017B18
    bl CreateMiniParaTitleObjs
.org 0x0801DE7A
    mov r0,60h ;centers "continue" text in password menu
;---------------------------------------------

;misc stuff
;file select stuff
.org 0x08025044 ::  .asciiz "One Player"
.org 0x08025318 ::  .asciiz "Compact"
.org 0x0802535C ::  .asciiz "Done"
.org 0x08025364 ::  .asciiz "Back"
.org 0x080253B0 ::  .asciiz "Yeah"
.org 0x080253B8 ::  .asciiz "Nope!"

;file select repointing
.org 0x08010F00 ::  .word @SinglePakVersus
.org 0x08011E5C ::  .word @StartNewGame
.org 0x08011EB4 ::  .word @FullSize
.org 0x08011EE0 ::  .word @EraseFile
.org 0x080127A8 ::  .word @FullSize
.org 0x0801274C ::  .word @NoDataStored
.org 0x080127C4 ::  .word @EraseWhichFile
.org 0x080128AC ::  .word @ReallyErase

;practice area select
.org 0x080253C8 ::  .asciiz "Area 1"    ::  .align
    .asciiz "Area 2"    ::  .align
    .asciiz "Area 3"    ::  .align
    .asciiz "Area 4"    ::  .align

;Password menu + multiplayer mode
.org 0x08025897 ::  .asciiz "CHAR"
.org 0x08025854 ::  .string "Stop"
.org 0x0801DE80 ::  .word @Continue

;Magic Menu
.org 0x08022EC4 ::  .word @Learn
.org 0x08028CE8 ::  .asciiz "Perform"
;HACK
.org 0x08022EAA
    add r0, 0Ah ;instead of 10h
    
;------------Deleet
.org 0x080015AC
    .word @DeleteData1
    .word @DeleteData2
    .word @DeleteDataYes
    .word @DeleteDataNo

.org 0x080015CC
    .word @CorruptedData1
    .word @CorruptedData2
    .word @CorruptedData3
    
.org 0x0800134E ; this subroutine call messes up the "delete all save data" prompt
    nop ::  nop
    
.org 0x080014DA ; this subroutine call messes up the "save data corrupted" text
    nop ::  nop
    
;re-position some strings
.org 0x0800138C ::  mov r0, 0x5C
.org 0x0800139A ::  mov r0, 0x5C
.org 0x080013DC ::  mov r0, 0x70

.org 0x08001518 ::  mov r0, 0x54
.org 0x08001524 ::  mov r0, 0x56
.org 0x08001530 ::  mov r0, 0x44

;------------------------
;fix name select keyboard to get rid of Japanese characters!
.org 0x080250CC
    .ascii "@\+-*/<>  " :: .align
    .ascii "!$%&'()~^=" :: .align
    .ascii "0123456789" :: .align
    .ascii "uvwxyz,.;:" :: .align
    .ascii "klmnopqrst" :: .align
    .ascii "abcdefghij" :: .align
    .ascii "#@\+-*/<>  " :: .align
    .ascii "#!$%&'()~^=" :: .align
    .ascii "#0123456789" :: .align
    .ascii "#UVWXYZ,.;:" :: .align
    .ascii "#KLMNOPQRST" :: .align
    .ascii "#ABCDEFGHIJ" :: .align
.org 0x08025340
    .ascii " ABCD "
.org 0x08025348
    .ascii " abcd "

;--------------------------- Credits Hacking
.include "text/credits.asm"

bytesPerLine equ 0x1E

.macro creditLine,line
    .ascii line
    .skip bytesPerLine - strlen(line)
.endmacro

.org  0x0803A448
.fill 0x0803BD7C-0x0803A448,0
.org  0x0803A448
.area 0x0803BD7C-.
creditLine s_credits0 :: .skip bytesPerLine*6
creditLine s_credits1 :: .skip bytesPerLine
creditLine s_credits2 :: .skip bytesPerLine*7
creditLine s_credits3 :: .skip bytesPerLine
creditLine s_credits4 :: .skip bytesPerLine
creditLine s_credits5 :: .skip bytesPerLine
creditLine s_credits6 :: .skip bytesPerLine
creditLine s_credits7 :: .skip bytesPerLine*7
creditLine s_credits8 :: .skip bytesPerLine
creditLine s_credits9 :: .skip bytesPerLine*7
creditLine s_credits10:: .skip bytesPerLine
creditLine s_credits11:: .skip bytesPerLine*7
creditLine s_credits12:: .skip bytesPerLine
creditLine s_credits13:: .skip bytesPerLine
creditLine s_credits14:: .skip bytesPerLine*7
creditLine s_credits15:: .skip bytesPerLine
creditLine s_credits16:: .skip bytesPerLine*2
creditLine s_credits17:: .skip bytesPerLine
creditLine s_credits18:: .skip bytesPerLine
creditLine s_credits19:: .skip bytesPerLine*2
creditLine s_credits20:: .skip bytesPerLine*7
creditLine s_credits21:: .skip bytesPerLine
creditLine s_credits22:: .skip bytesPerLine*7
creditLine s_credits23:: .skip bytesPerLine
creditLine s_credits24:: .skip bytesPerLine*7
creditLine s_credits25:: .skip bytesPerLine
creditLine s_credits26:: .skip bytesPerLine
creditLine s_credits27:: .skip bytesPerLine*7
creditLine s_credits28:: .skip bytesPerLine
creditLine s_credits29:: .skip bytesPerLine*7
creditLine s_credits30:: .skip bytesPerLine
creditLine s_credits31:: .skip bytesPerLine
creditLine s_credits32:: .skip bytesPerLine*7
creditLine s_credits33:: .skip bytesPerLine
creditLine s_credits34:: .skip bytesPerLine*7
creditLine s_credits35:: .skip bytesPerLine
creditLine s_credits36:: .skip bytesPerLine
creditLine s_credits37:: .skip bytesPerLine*7
creditLine s_credits38:: .skip bytesPerLine
creditLine s_credits39:: .skip bytesPerLine*7
creditLine s_credits40:: .skip bytesPerLine
creditLine s_credits41:: .skip bytesPerLine*7
creditLine s_credits42:: .skip bytesPerLine
creditLine s_credits43:: .skip bytesPerLine
creditLine s_credits44:: .skip bytesPerLine*7
creditLine s_credits45:: .skip bytesPerLine
creditLine s_credits46:: .skip bytesPerLine
creditLine s_credits47:: .skip bytesPerLine*7
creditLine s_credits48:: .skip bytesPerLine
creditLine s_credits49:: .skip bytesPerLine*2
creditLine s_credits50:: .skip bytesPerLine
creditLine s_credits51:: .skip bytesPerLine
creditLine s_credits52

.endarea

;---------------------------
;Random names in name select when you press START when name is blank
.org 0x0802DF30
    .word @Name0
    .word @Name1
    .word @Name2
    .word @Name3
    .word @Name4
    .word @Name5
    .word @Name6
    .word @Name7
    
;----------------------------
; repointing magic trick names
.org 0x0803C07C
    .word @KururinShock
    .word @TenAndHundred
    .word @BookTest
    .word @TimeParadox
    .word @SoundCatch
    .word @CenterPoint
    .word @GameBoyPanic
    .word @Impression
    .word @Twist
    .word @Imagine
    .word @LoveTester
    .word @CaliforniaFlip
    .word @DoctorKururin
    .word @Microwave
    .word @UpDown
    .word @DontTouch