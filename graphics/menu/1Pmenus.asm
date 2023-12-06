; hack multiplayer results on parent GBA
; don't need to change graphics data at all. just truncate the object size to remove the JP glyph
.org 0x08136710+4
    .byte 0xFD,0xEE,0x11,0x04 ; shift right by 7 px (originally F6), object size down to 8x8 from 32x8
.org 0x0813674A+4
    .byte 0xFC,0x0E,0x11,0x04 ; shift right by 7 px (originally F6), object size down to 8x8 from 32x8
.org 0x08136794+4
    .byte 0xFC,0x1E,0x11,0x04 ; shift right by 7 px (originally F6), object size down to 8x8 from 32x8
.org 0x081367E1+4
    .byte 0xFC,0x2E,0x11,0x04 ; shift right by 7 px (originally F6), object size down to 8x8 from 32x8
    

.org 0x081BC4FC ; replace graphical data in place, without any repointing (takes same space)
    .incbin "graphics/menu/dumps/random.dmp"
    
.org 0x081BC138 ; my binary takes up 0x39B bytes, I have 0x3C4 to work with, I think
    .incbin "graphics/menu/dumps/bubblenums.dmp"

.autoregion
    @BubbleNums:
    .incbin "graphics/menu/dumps/bubblenums.dmp" :: .align
    @Adventure:		
    menu_button_128x16_header
    .incbin "graphics/menu/dumps/1PAdventure.dmp" :: .align
	@Practice:		
    menu_button_128x16_header
    .incbin "graphics/menu/dumps/1PPractice.dmp" :: .align
	@Challenge:		
    menu_button_128x16_header
    .incbin "graphics/menu/dumps/1PChallenge.dmp" :: .align
	@Magic:			
    menu_button_128x16_header
    .incbin "graphics/menu/dumps/1PMagic.dmp" :: .align
	@KuruKururin:	
    menu_button_128x16_header
    .incbin "graphics/menu/dumps/1PKurukuruKururin.dmp" :: .align
	@MinigameParadise:	
    menu_button_128x16_header
    .incbin "graphics/menu/dumps/1PMinigameParadise.dmp" :: .align
    @OneCartVersus:
		.byte 0x05,0xF0,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1PSinglePakVersus.dmp"
		.word 0x00000000
		.align
	@P2KuruKururin:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P2PKurukuruKururin.dmp"
		.word 0x00000000
		.align
	@P3KuruKururin:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P3PKurukuruKururin.dmp"
		.word 0x00000000
		.align
	@P4KuruKururin:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P4PKurukuruKururin.dmp"
		.word 0x00000000
		.align
	@P2MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P2PMinigameParadise.dmp"
		.word 0x00000000
		.align
	@P3MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P3PMinigameParadise.dmp"
		.word 0x00000000
		.align
	@P4MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P4PMinigameParadise.dmp"
		.word 0x00000000
		.align
    @FreePlay:
        menu_button_128x16_header_compressed
        .incbin "graphics/menu/dumps/MultiFreePlay.dmp"
        .word 0x00000000
        .align
    @RoundLimit:
        menu_button_128x16_header_compressed
        .incbin "graphics/menu/dumps/MultiRoundLimit.dmp"
        .word 0x00000000
        .align
    @TimeLimit:
        menu_button_128x16_header_compressed
        .incbin "graphics/menu/dumps/MultiTimeLimit.dmp"
        .word 0x00000000
        .align
.endautoregion

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
;Multiplayer Menus repointing compressed GFX
;TODO - change menu buttons for non-parent GBA's
.org 0x08015CA8
	.word @OneCartVersus
.org 0x0802E644
	.word @KuruKururin
	.word @KuruKururin
	.word @P2KuruKururin
	.word @P3KuruKururin
	.word @P4KuruKururin
	.word @MinigameParadise
	.word @MinigameParadise
	.word @P2MinigameParadise
	.word @P3MinigameParadise
	.word @P4MinigameParadise
.org 0x0802ECB8
    .word @FreePlay
    .word @RoundLimit
    .word @TimeLimit
.org 0x0802ECC4
	.word @P2KuruKururin
	.word @P3KuruKururin
	.word @P4KuruKururin
	.word @P2MinigameParadise
	.word @P3MinigameParadise
	.word @P4MinigameParadise
	
;------------------------
