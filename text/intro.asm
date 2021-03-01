.org 0x08010DC4 ;starting intro cutscene from game boot
	.word @NewIntroScript
.org 0x08011DD0 ;starting intro cutscene from mode select
	.word script_loc1
	
.org 0x08010DF0
	.word script_loc1
	
.org 0x080A77C8
.region 0xABC1C-0xA77C8, 00 ;deletes original intro cutscene data
.endregion

;Intro modifications
	.org 0x080A6FE2
		.byte 0x0F ;custom command to add variable width

.macro _str,msg
	.stringn msg+"<end>" :: .align 4
.endmacro

.loadtable "text/kp_eng.tbl" ;original table bugs out with capital M's

;TODO: move these to own file
s_intro1 equ "Kururin Village, always quiet..."
s_intro2 equ "Until..."
s_intro3 equ "Magic show at 6:00 PM"
s_intro4 equ "Let's go see, everyone!"
s_intro5 equ "I'm late! I'm late!"
s_intro6 equ "...Huh? Where is everyone?"
s_intro7 equ "How strange~"
s_intro8 equ "To the Helirin!"

.org 0x08840000
@NewIntroScript:
	.include "asm/scriptcode/intro_sc.asm"