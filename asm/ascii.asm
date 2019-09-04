.org 0x080AFB18	;new data with widths of the ascii font
	.incbin "bin/asciiwidthtable.bin"

;custom grade graphics
.org 0x08139854
	.incbin "bin/customgradeascii.bin"
	
;mirror lowercase ASCII characters to fix them in challenge pause menus
.org 0x08139D14
	.incbin "bin/lowercaseascii.bin"

.org 0x08280230	;rewrite graphics in minigame pause menu
	.incbin "bin/minigamepausemenu.bin"

.org 0x08024D7D ;teacher hare
	.byte 0x86,0x87,0x88,0x89,0x8A,0x8B ;see table corresponding to replaced characters in gfx
	
.org 0x08024D87 ;baron magic
	.byte 0x8C,0x8D,0x8E,0x8F,0x90,0x91
	
.org 0x08024D91 ;kururin's dad
	.byte 0x92,0x93,0x94,0x95,0x96,0x97
	
.org 0x0803C269
	.byte 	0x82,0x80,0x00, \ ;T grade
			0x83,0x80,0x00, \ ;B grade
			0x84,0x80,0x00    ;M grade
			
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

;bird names
;the bird names: Chikurin,  Hoyorin,	Gizarin (Kakurin?),	Loverin,	Gekirin
;	Fuwarin,	Maririn,	Pokorin,	Hikarin,	Hyokorin
;bird name pointer list: 0x08029098?
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
	MiniParaTitles: .incbin "bin/minigameparadiselabels.bin"
.endarea
	
	
.org 0x080172FE
	bl MiniParaTitleHook
.org 0x08017B18
	bl CreateMiniParaTitleObjs
;---------------------------------------------

;misc stuff
;file select stuff
.org 0x08025044	::	.asciiz "One Player"
.org 0x08025318	::	.asciiz "Compact"
.org 0x0802535C	::	.asciiz "Confirm"
.org 0x08025364	::	.asciiz "Delete"
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

