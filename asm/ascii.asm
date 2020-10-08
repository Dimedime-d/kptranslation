.org 0x080AFB18	;new data with widths of the ascii font
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

.org 0x08280230	;rewrite graphics in minigame pause menu
	.incbin "bin/minigamepausemenu.bin"

.org 0x08024D7D ;teacher hare
	.ascii "Hare"
	
.org 0x08024D87 ;baron magic
	.ascii "Magic"
	
.org 0x08024D91 ;kururin's dad
	.ascii "Dad" :: .byte 0x00, 0x00
	
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
	.string "Retry"	::	.align
	.string "Resume"		::	.align
	.string "Give up"	::	.align
.org 0x08024DDC
	.string "See Demo"	::	.align
.org 0x08024E00
	.string "Continue"	::	.align
.org 0x08024DE8
	.string "Exit Demo"	::	.align
	
;repointing text
.org 0x08029338 	:: 	.word @SeeCourse	::	.word @QuitLevel 
.org 0x0802934C		::	.word @QuitLevel
.org 0x08029354		::	.word @SeeCourse ::	.word @QuitLevel
.org 0x08029368		::	.word @SeeCourse	::	.word @QuitLevel
.org 0x08029374		::	.word @RestartDemo	::	.word @SeeCourse
.org 0x08029394		::	.word @SeeCourse	::	.word @QuitLevel
.org 0x080293A0		::	.word @RestartDemo	::	.word @SeeCourse	::	.word @SavePassword :: \
	.word @StopReplay	::	.word @RestartDemo	::	.word @SeeCourse	::	.word @SavePassword  :: \
	.word @StopReplay

.org 0x08024CE0
	.asciiz "Pokorin"	::	.align
	.asciiz "Pikarin"	::	.align
	.asciiz "Hoyorin"	::	.align
	.asciiz "Fuwarin"	::	.align
	.asciiz "Gekirin"	::	.align
.org 0x08024D10
	.asciiz "Loverin"	::	.align
	.asciiz "Maririn"	::	.align
	.asciiz "Kakurin"	::	.align
	
;more repointing
.org 0x08029098	::	.word @Hyokorin
.org 0x080290A8	::	.word @Chikurin	::	.word @Hyokorin
.org 0x080290D0	::	.word @Chikurin

;---------------------------------------------
;Text that doesn't fit in original space
.org 0x08830000
.area 0x10000
	@SeeCourse: 		.string "See Course"		::	.align
	@QuitLevel: 	.string "Quit Level" 	:: 	.align
	@RestartDemo:	.string "Restart Demo"	::	.align
	@SavePassword:	.string "Save Password"	::	.align
	@StopReplay:		.string "Stop Replay"	::	.align
	@Hyokorin:	.asciiz "Hyokorin"	::	.align
	@Chikurin:	.asciiz "Chikurin"	::	.align
	@SinglePakVersus:	.asciiz "Single Pak Versus"	::	.align
	@StartNewGame:	.asciiz "Start New Game"	::	.align
	@FullSize:	.asciiz	"Full Size"	::	.align
	@EraseFile:	.asciiz "Erase File"	::	.align
	@NoDataStored:	.asciiz "No Data Stored"	::	.align
	@EraseWhichFile:	.asciiz "Erase which file?"	::	.align
	@ReallyErase:	.asciiz "Really delete this file?"	::	.align
	@ChuChuPanic:	.asciiz "Chu-Chu Panic"	::	.align
	@StarlightRomance:	.asciiz	"Starlight Romance"	::		.align
	@GrassCutter:	.asciiz "Grass Cutter"	::	.align
	@FallingDown:	.asciiz "Falling Down"	::	.align
	@MagnetForce:	.asciiz "Magnet Force"	::	.align
	@Continue:	.asciiz "Continue"	::	.align
	@Name0:		.asciiz "Kururin"	::	.align
	@Name1:		.asciiz "Kurukuru"	::	.align
	@Name2:		.asciiz "Nanashi"	::	.align
	@Name3:		.asciiz "Dimedime"	::	.align
	@Name4:		.asciiz "Tekitou"	::	.align
	@Name5:		.asciiz "Guest"		::	.align
	@Name6:		.asciiz "KuruPara"	::	.align
	@Name7:		.asciiz "Paradise"	::	.align
	@Learn:		.asciiz "   Learn" ::	.align
	MiniParaTitles: .incbin "bin/minigameparadiselabels.bin"
	@Adventure:		.incbin "bin/menus/adventure_EN.bin"
	@Practice:		.incbin "bin/menus/practice_EN.bin"
	@Challenge:		.incbin "bin/menus/challenge_EN.bin"
	@Magic:			.incbin "bin/menus/magic_EN.bin"
	@KuruKururin:	.incbin "bin/menus/kurukurukururin_EN.bin"
	@MinigameParadise:	.incbin "bin/menus/minigameparadise_EN.bin"
	@OneCartVersus:
		.byte 	0x05,0xF0,0x48,0x08,0xB7,0xF8,0x24,0x08, \
				0xD7,0xF8,0x24,0x08,0xF6,0xF8,0x24,0x08, \
				0x15,0xF8,0x24,0x08,0x34,0xF8,0x24,0x08
		.incbin "bin/menus/singlepakversus_EN_comp.bin"
.endarea
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
.org 0x08025044	::	.asciiz "One Player"
.org 0x08025318	::	.asciiz "Compact"
.org 0x0802535C	::	.asciiz "Done"
.org 0x08025364	::	.asciiz "Back"
.org 0x080253B0	::	.asciiz "Yeah"
.org 0x080253B8	::	.asciiz "Nope!"

;file select repointing
.org 0x08010F00	::	.word @SinglePakVersus
.org 0x08011E5C	::	.word @StartNewGame
.org 0x08011EB4	::	.word @FullSize
.org 0x08011EE0	::	.word @EraseFile
.org 0x080127A8	::	.word @FullSize
.org 0x0801274C	::	.word @NoDataStored
.org 0x080127C4	::	.word @EraseWhichFile
.org 0x080128AC	::	.word @ReallyErase

;practice area select
.org 0x080253C8	::	.asciiz "Area 1"	::	.align
	.asciiz "Area 2"	::	.align
	.asciiz "Area 3"	::	.align
	.asciiz "Area 4"	::	.align

;Minigame select
.org 0x08025524	::	.asciiz	"Random"		
.org 0x0802550C	::	.asciiz "Crossfire"		
.org 0x080254EC	::	.asciiz "Super Jumper"	
.org 0x080254E0	::	.asciiz "Smash Force"	
.org 0x080254D8	::	.asciiz "Occupy"		
.org 0x080254BC	::	.asciiz "Slip Drop"		
.org 0x080254B0	::	.asciiz "In the Sky"	
.org 0x080254A4	::	.asciiz "Quick Flip"	
.org 0x08025498	::	.asciiz "Love Attack"	
.org 0x08025470	::	.asciiz "Pit-Pat Racer"	
.org 0x08025464	::	.asciiz "Spin Shot"		
.org 0x08025458	::	.asciiz "Twin Hopper"	

;Minigame select repointing
.org 0x0802E680	::	.word @ChuChuPanic
.org 0x0802E688	::	.word @StarlightRomance
.org 0x0802E698	::	.word @GrassCutter
.org 0x0802E6AC	::	.word @FallingDown
	.word @MagnetForce

;Password menu
.org 0x08025897	::	.asciiz "CHAR"
.org 0x08025854	::	.asciiz "Stop"
.org 0x0801DE80	::	.word @Continue

;Magic Menu
.org 0x08022EC4 ::	.word @Learn
.org 0x08028CE8 ::	.asciiz "Perform"
;HACK
.org 0x08022EAA
	add r0, 0Ah ;instead of 10h

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
	
;----------------------
;Single-Player Menus repointing GFX
.org 0x0802DF50
	.word @Adventure
	.word @Practice
	.word @Challenge
	.word @Magic
.org 0x0802DF68
	.word @KuruKururin
	.word @MinigameParadise
	
;----------------------
;Multiplayer Menus repointing compressed GFX TODO: fix compression algorithim
.org 0x08015CA8
	.word @OneCartVersus