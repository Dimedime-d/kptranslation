.loadtable "text/kp_eng.tbl" ;original table bugs out with capital M's

;menu description edits
.org 0x08023288
	bl MenuAddVW

;hack to above
.org 0x080231BE
	b 0x08023288

.macro repointText,ptrLoc,msg
	.autoregion
	@txtPtr:
		.stringn msg+"<end>" :: .align 4
	.endautoregion
	.org ptrLoc
		.word @txtPtr
.endmacro

repointText 0x0802DF70,"Venture many lands and" ;Adventure
repointText 0x0802DF74,"search for your family!"
repointText 0x0802DF78,"Practice courses from the" ;Practice
repointText 0x0802DF7C,"Adventure Mode!"
repointText 0x0802DF80,"Test your skills on" ;Challenge
repointText 0x0802DF84,"Courses and minigames!"
repointText 0x0802DF88,"Perform magic using" ;Magic
repointText 0x0802DF8C,"your GBA!"

repointText 0x0802DF90,"Take the big Helirin for" ;Size/Difficulty selection
repointText 0x0802DF94,"your adventure!"
repointText 0x0802DF98,"Take the small Helirin for" ;Size/Difficulty selection
repointText 0x0802DF9C,"your adventure!"

repointText 0x0802DFA0,"Challenge short courses!" ;Challenge options
repointText 0x0802DFA4," "
repointText 0x0802DFA8,"Challenge various minigames!"
repointText 0x0802DFAC," "

repointText 0x0802E5F4,"Compete in short courses!" ;Multiplayer challenge options
repointText 0x0802E5F8," "
repointText 0x0802E5FC,"Compete in various minigames!"
repointText 0x0802E600," "

repointText 0x0802EB98,"Freely play your favorite" ;Multiplayer "short courses" options
repointText 0x0802EB9C,"courses over and over again!"
repointText 0x0802EBA0,"Play for a set number of rounds."
repointText 0x0802EBA4,"Get the most points to win!"
repointText 0x0802EBA8,"Play many rounds under the"
repointtext 0x0802EBAC,"time limit. Most points wins!"

repointText 0x0802EBB0,"Freely play any minigame!" ;Multiplayer "minigames" options
repointText 0x0802EBB4," "
repointText 0x0802EBB8,"Play a set number of minigames."
repointText 0x0802EBBC,"Get the most points to win!"
repointText 0x0802EBC0,"Play many minigames under the"
repointText 0x0802EBC4,"time limit. Most points wins!"

repointText 0x080228D0,"To perform the Magic you've" ;Performing magic
repointText 0x080228D4,"selected, turn off the power"
repointtext 0x080228D8,"now. Remove the cartridge,"
repointText 0x080228DC,"turn the power back on again"
repointText 0x080228E0,"and the Magic will begin!"

;-----------------------------
.macro FourWideMenuObjData
	.byte 0xB7,0xF8,0x24,0x08
	.byte 0xD7,0xF8,0x24,0x08
	.byte 0xF7,0xF8,0x24,0x08
	.byte 0x17,0xF8,0x24,0x08
	.byte 0x37,0xF8,0x24,0x08
.endmacro

.autoregion
	@Adventure:		.incbin "bin/menus/adventure_EN.bin"
	@Practice:		.incbin "bin/menus/practice_EN.bin"
	@Challenge:		.incbin "bin/menus/challenge_EN.bin"
	@Magic:			.incbin "bin/menus/magic_EN.bin"
	@KuruKururin:	.incbin "bin/menus/kurukurukururin_EN.bin"
	@MinigameParadise:	.incbin "bin/menus/minigameparadise_EN.bin"
	@OneCartVersus:
		.byte 0x05,0xF0,0x48,0x08
		FourWideMenuObjData
		.incbin "bin/menus/multiplayer/singlepakversus_EN_comp.bin"
		.word 0x00000000
		.align 4
	@P2KuruKururin:
		.byte 0x05,0x80,0x48,0x08
		FourWideMenuObjData
		.incbin "bin/menus/multiplayer/2PKuruKuruKururin_EN_comp.bin"
		.word 0x00000000
		.align 4
	@P3KuruKururin:
		.byte 0x05,0x80,0x48,0x08
		FourWideMenuObjData
		.incbin "bin/menus/multiplayer/3PKuruKuruKururin_EN_comp.bin"
		.word 0x00000000
		.align 4
	@P4KuruKururin:
		.byte 0x05,0x80,0x48,0x08
		FourWideMenuObjData
		.incbin "bin/menus/multiplayer/4PKuruKuruKururin_EN_comp.bin"
		.word 0x00000000
		.align 4
	@P2MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		FourWideMenuObjData
		.incbin "bin/menus/multiplayer/2PMinigameParadise_EN_comp.bin"
		.word 0x00000000
		.align 4
	@P3MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		FourWideMenuObjData
		.incbin "bin/menus/multiplayer/3PMinigameParadise_EN_comp.bin"
		.word 0x00000000
		.align 4
	@P4MinigameParadise:
		.byte 0x05,0x80,0x48,0x08
		FourWideMenuObjData
		.incbin "bin/menus/multiplayer/4PMinigameParadise_EN_comp.bin"
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
