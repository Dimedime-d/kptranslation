.macro _str,msg
	.stringn msg+"<end>" :: .align 4
.endmacro

;repointing stuff
.org 0x08006E9C
	.word @NewEndingScript

.org 0x0802E4B4
	.word @Kappado1start
	.word @Kappado1redo

.org 0x0802EA9C
	.word @Kappado1lose
	.word @Kappado1win

.org 0x08010DC4 ;starting intro cutscene from game boot
	.word @NewIntroScript
.org 0x08011DD0 ;starting intro cutscene from mode select
	.word script_loc1
	
.org 0x08010DF0
	.word script_loc1
	
.org 0x080A77C8
.region 0xABC1C-0xA77C8, 00 ;deletes original intro cutscene data
.endregion

;---------------- Intro modifications
.org 0x080A6FE2
.byte 0x0F ;custom command to add variable width
	
.org 0x080A701C
.word 0x30 ;placeholder on max # of characters per line (intro)

;---------------- Ending modifications
.org 0x080959DE
.byte 0x0F ;vwf

.org 0x08095A18
.byte 0x30 ;chars per line

.org 0x08095998
.byte 0x03 ;faster text, needed to sync with ending music (need to lose ~40 frames)

;---------------- Dialogue modifications
.org 0x080960EA ;taken from nextscriptpointer.asm
.byte 0x0F ;vwf code in 1st Kappado encounter (TODO: Repoint every cutscene script and change code that adds width)

.org 0x08096118
.byte 0x30 ;max # characters per line (dialogue), shouldn't need this 'cause I'd just use <line>s.

sndOffset equ 0x78 ;originally 0x40, makes more space for characters

.org 0x08096044
.byte sndOffset + 1 ;hack related to storage sound effects

.org 0x0809583C
.byte 0xC0 ;originally 0x60, gives more space for text/sounds

.org 0x0803A360 ;sounds for lowercase letters
.byte 0x3E,0x39,0x3F,0x3A,0x40,0x3B,0x41,0x3C,0x42,0x3D,0x39,0x3E,0x3A, \
	  0x3F,0x3B,0x40,0x3C,0x41,0x3D,0x3C,0x39,0x3E,0x3A,0x3F,0x3B,0x40
	  
.org 0x0809608C
.byte 0x03 ;lower = faster dialogue speed (at the cost of audio) 0x06 originally

.org 0x08095CE4
.byte 0x50 ;originally 0x26, deletes all text chars

;----------------- Special text box (green/pink) modifications
.org 0x080AC574
.byte 0x50 ;delete all chars

.org 0x080AC6D0
.byte 0x03 ;dialogue speed

.org 0x080AC716
.byte 0x0F ;custom vwf code

.org 0x080AC744
.byte 0x30 ;max chars per line

;----------------- Credits modifications
.org 0x080A6504
.byte 0x5D ;reposition "The end"

.org 0x080A651C
_str " FIN"

;-----------------

.macro S_unlockMinigame,game
	_str "\""+game+"\""+" was added<line>to the Challenge menu!"
.endmacro

.macro S_unlockMagic,magic
	_str "\""+magic+"\""+" was added<line> to the Magic menu!"
.endmacro

.macro loadChars,msg
	.byte 0x0A,0x00,0x14,0x00,0x18,0xFF,0xFF,0x7F
	_str msg
.endmacro

.macro loadCharsAndSfx,msg
	loadChars msg
	.byte 0x0F,0x00,0x04,0x00,sndOffset,0xFF,0xFF,0x7F
	_str msg
.endmacro

.loadtable "text/kp_eng.tbl" ;original table bugs out with capital M's

.include "text/dialogue.asm"

.org 0x08840000
@NewIntroScript:
	.include "asm/scriptcode/intro_sc.asm"
@Kappado1start:
	.include "asm/scriptcode/kappado/kappado1start.asm"
@Kappado1lose:
	.include "asm/scriptcode/kappado/kappado1lose.asm"
@Kappado1redo:
	.include "asm/scriptcode/kappado/kappado1redo.asm"
@Kappado1win:
	.include "asm/scriptcode/kappado/kappado1win.asm"
@NewEndingScript:
	.include "asm/scriptcode/ending.asm"
MinigameUnlock:
	.include "asm/scriptcode/minigameunlock.asm"
MagicUnlock:
	.include "asm/scriptcode/magicunlock.asm"