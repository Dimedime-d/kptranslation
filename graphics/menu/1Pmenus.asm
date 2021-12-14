
.autoregion
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
		.align 4
	@P3KuruKururin:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P3PKurukuruKururin.dmp"
		.word 0x00000000
		.align 4
	@P4KuruKururin:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P4PKurukuruKururin.dmp"
		.word 0x00000000
		.align 4
	@P2MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P2PMinigameParadise.dmp"
		.word 0x00000000
		.align 4
	@P3MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P3PMinigameParadise.dmp"
		.word 0x00000000
		.align 4
	@P4MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		menu_button_160x16_header_partial
		.incbin "graphics/menu/dumps/1P4PMinigameParadise.dmp"
		.word 0x00000000
		.align 4
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
.org 0x0802ECC4
	.word @P2KuruKururin
	.word @P3KuruKururin
	.word @P4KuruKururin
	.word @P2MinigameParadise
	.word @P3MinigameParadise
	.word @P4MinigameParadise
	
;------------------------
