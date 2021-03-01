.org 0x08010DC4
	.word @NewIntroScript
	
.org 0x08010DF0
	.word script_loc1
	
.org 0x080A77C8
.region 0xABC64-0xA77C8, 00 ;deletes original intro cutscene data
.endregion

;Intro modifications
	.org 0x080A6FE2
		.byte 0x0F ;custom command to add variable width

.macro _str,msg
	.stringn msg+"<end>" :: .align 4
.endmacro

.macro introscript,num
	.include "asm/scriptcode/intro/intro" + num + ".asm"
.endmacro

.loadtable "text/kp_eng.tbl" ;original table bugs out with capital M's

.org 0x08840000
@NewIntroScript:
	introscript 1 ;Nintendo logo, fade-in to village
	_str "Kururin Village, always quiet..."
	introscript 2 ;Fadeout
	_str "Until..."
	introscript 3 ;Magic show on TV
	_str "Magic show at 6:00 PM"
	introscript 4 ;Cut to outside tent
	_str "5:16"
	introscript 5 ;Birds walk inside tent
	_str "Let's go see, everyone!"
	introscript 6 ;Kururin runs toward tent, other times are included here
	_str "I'm late! I'm late!"
	introscript 7 ;Kururin looks around in tent
	_str "...Huh?"
	introscript 8 ;Close-up of Kururin
	_str "How strange~"
	introscript 9
	_str "To the Helirin!"
	introscript 10 ;Long-ish sequence of Kururin running back, jumping into Helirin, and flying away