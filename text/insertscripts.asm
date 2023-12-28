.macro _str,msg
	.stringn msg+"<end>" :: .align 4
.endmacro

;repointing stuff
.org 0x08006E9C
	.word @NewEndingScript

.org 0x0802E4B4 ;repointing cutscene script locations
    StartRetryArray:
	.word @Kappado1start
	.word @Kappado1redo
	.word @Kappado2start
	.word @Kappado2redo
	.word @Kappado3start
	.word @Kappado3redo
	.word @Tenko1start
	.word @Tenko1redo
	.word @Tenko2start
	.word @Tenko2redo
	.word @Tenko3start
	.word @Tenko3redo
	.word @Naporon1start
	.word @Naporon1redo
	.word @Naporon2start
	.word @Naporon2redo
	.word @Naporon3start
	.word @Naporon3redo
	.word @Baron1start
	.word @Baron1redo
	.word @Baron2start
	.word @Baron2redo
	.word @Baron3start
	.word @Baron3redo

.org 0x0802EA9C
    LoseWinArray:
	.word @Kappado1lose
	.word @Kappado1win
	.word @Kappado2lose
	.word @Kappado2win
	.word @Kappado3lose
	.word @Kappado3win
	.word @Tenko1lose
	.word @Tenko1win
	.word @Tenko2lose
	.word @Tenko2win
	.word @Tenko3lose
	.word @Tenko3win
	.word @Naporon1lose
	.word @Naporon1win
	.word @Naporon2lose
	.word @Naporon2win
	.word @Naporon3lose
	.word @Naporon3win
	.word @Baron1lose
	.word @Baron1win
	.word @Baron2lose
	.word @Baron2win
	.word @Baron3lose
    Baron3Win:
	.word @Baron3win
    
.org 0x080292DC
    .word @TeacherHareRankUpWorld1
    .word @TeacherHareRankUpWorld2
    .word @TeacherHareRankUpWorld3
    .word @TeacherHareRankUpWorld4
    .word @BaronMagicRankUpWorld1
    .word @BaronMagicRankUpWorld2
    .word @BaronMagicRankUpWorld3
    .word @BaronMagicRankUpWorld4
    .word @DadRankUp1
    .word @DadRankUp2
    .word @DadRankUp3
    .word @DadRankUp4

.org 0x08010DC4 ;starting intro cutscene from game boot
	.word @NewIntroScript
.org 0x08011DD0 ;starting intro cutscene from mode select
	.word script_loc1

.org 0x0801A38C ;beat Baron Magic's 3rd minigame, and it's the last one 
    LastBaronWin:
	.word @Baron3winlast

.org 0x0801324C ;cutscene with Baron Magic before Neo Land
    NeoLandCutscene:
	.word @Intermission
	
.org 0x08010DF0
	.word script_loc1
	
.org 0x080961DC
.region 0x080A33D4-., 00 ;delete every cutscene from kappado 1 start to dad rank up 4
.endregion
    
.org 0x080A77C8
.region 0xABC1C-0xA77C8, 00 ;deletes original intro cutscene data
.endregion

;---------------- Intro modifications
.org 0x080A6FE2
.byte 0x0F ;custom command to add variable width
	
.org 0x080A701C
.word 0x30 ;placeholder on max # of characters per line (intro)

.org 0x080A6F9C
.byte 0x04 ;faster text, 0x04 originally

;---------------- Ending modifications
.org 0x080959DE
.byte 0x0F ;vwf

.org 0x08095A18
.byte 0x30 ;chars per line

.org 0x08095998
.byte 0x03 ;faster text, needed to sync with ending music (need to lose ~40 frames) 0x06 originally

;---------------- Dialogue modifications
.org 0x080960EA ;taken from nextscriptpointer.asm
.byte 0x0F ;vwf code in 1st Kappado encounter

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

;--------------Animation modifications

; fixes one of Tenko's animations, she no longer bobs up and down unusually fast.
.org 0x08031B34 ::  .byte 0x10
    .skip 0x0B  ::  .byte 0x0C  ::  .skip 0x0B  ::  .byte 0x0C
    .skip 0x0B  ::  .byte 0x0C  ::  .skip 0x0B  ::  .byte 0x0C

;----------------- Neo Land Intermission dialogue modifications (can press A to display all text)

.org 0x08095EFC
.byte 0x30 ;max # of chars per line

.org 0x08095E10
.byte sndOffset + 1 ;sound effect storage hack

.org 0x08095E70
.byte 0x03 ;faster dialogue speed (0x06 originally)

.org 0x08095ECE
.byte 0x0F ;custom vwf code

;----------------- Special text box (green/pink) modifications
.org 0x080AC574
.byte 0x50 ;delete all chars

.org 0x080AC6D0
.byte 0x03 ;dialogue speed

.org 0x080AC716
.byte 0x0F ;custom vwf code

.org 0x080AC744
.byte 0x30 ;max chars per line

;----------------- helper macros for custom bytecode

.macro loadCharsWithID,id
    .byte 0x0A,0x00,0x14,0x00,0x18,0xFF,0xFF,0x7F
	.word id
.endmacro

.macro loadCharsInstantWithID,id
	.byte 0x0A,0x00,0x1A,0x00,0x18,0xFF,0xFF,0x7F ;0x1A custom code auto-centers instantly displayed text
	.word id
.endmacro

.macro loadCharsAndSfxWithID,id
    loadCharsWithID id
    .byte 0x0F,0x00,0x04,0x00,sndOffset,0xFF,0xFF,0x7F
	.word id
.endmacro

.loadtable "text/kp_eng.tbl" ;original table bugs out with capital M's

.include "text/dialogue.asm"

.autoregion :: .align
@NewIntroScript:
	.include "asm/scriptcode/intro_sc.asm"
.endautoregion
.autoregion :: .align
@Kappado1start:
	.include "asm/scriptcode/kappado/kappado1start.asm"
.endautoregion
.autoregion :: .align
@Kappado1lose:
	.include "asm/scriptcode/kappado/kappado1lose.asm"
.endautoregion
.autoregion :: .align
@Kappado1redo:
	.include "asm/scriptcode/kappado/kappado1redo.asm"
.endautoregion
.autoregion :: .align
@Kappado1win:
	.include "asm/scriptcode/kappado/kappado1win.asm"
.endautoregion
.autoregion :: .align
@Kappado2start:
	.include "asm/scriptcode/kappado/kappado2start.asm"
.endautoregion
.autoregion :: .align
@Kappado2lose:
	.include "asm/scriptcode/kappado/kappado2lose.asm"
.endautoregion
.autoregion :: .align
@Kappado2redo:
	.include "asm/scriptcode/kappado/kappado2redo.asm"
.endautoregion
.autoregion :: .align
@Kappado2win:
	.include "asm/scriptcode/kappado/kappado2win.asm"
.endautoregion
.autoregion :: .align
@Kappado3start:
	.include "asm/scriptcode/kappado/kappado3start.asm"
.endautoregion
.autoregion :: .align
@Kappado3lose:
	.include "asm/scriptcode/kappado/kappado3lose.asm"
.endautoregion
.autoregion :: .align
@Kappado3redo:
	.include "asm/scriptcode/kappado/kappado3redo.asm"
.endautoregion
.autoregion :: .align
@Kappado3win:
	.include "asm/scriptcode/kappado/kappado3win.asm"
.endautoregion
.autoregion :: .align
@Tenko1start:
	.include "asm/scriptcode/tenko/tenko1start.asm"
.endautoregion
.autoregion :: .align
@Tenko1lose:
	.include "asm/scriptcode/tenko/tenko1lose.asm"
.endautoregion
.autoregion :: .align
@Tenko1redo:
	.include "asm/scriptcode/tenko/tenko1redo.asm"
.endautoregion
.autoregion :: .align
@Tenko1win:
	.include "asm/scriptcode/tenko/tenko1win.asm"
.endautoregion
.autoregion :: .align
@Tenko2start:
	.include "asm/scriptcode/tenko/tenko2start.asm"
.endautoregion
.autoregion :: .align
@Tenko2lose:
	.include "asm/scriptcode/tenko/tenko2lose.asm"
.endautoregion
.autoregion :: .align
@Tenko2redo:
	.include "asm/scriptcode/tenko/tenko2redo.asm"
.endautoregion
.autoregion :: .align
@Tenko2win:
	.include "asm/scriptcode/tenko/tenko2win.asm"
.endautoregion
.autoregion :: .align
@Tenko3start:
	.include "asm/scriptcode/tenko/tenko3start.asm"
.endautoregion
.autoregion :: .align
@Tenko3lose:
	.include "asm/scriptcode/tenko/tenko3lose.asm"
.endautoregion
.autoregion :: .align
@Tenko3redo:
	.include "asm/scriptcode/tenko/tenko3redo.asm"
.endautoregion
.autoregion :: .align
@Tenko3win:
	.include "asm/scriptcode/tenko/tenko3win.asm"
.endautoregion
.autoregion :: .align
@Naporon1start:
	.include "asm/scriptcode/naporon/naporon1start.asm"
.endautoregion
.autoregion :: .align
@Naporon1lose:
	.include "asm/scriptcode/naporon/naporon1lose.asm"
.endautoregion
.autoregion :: .align
@Naporon1redo:
	.include "asm/scriptcode/naporon/naporon1redo.asm"
.endautoregion
.autoregion :: .align
@Naporon1win:
	.include "asm/scriptcode/naporon/naporon1win.asm"
.endautoregion
.autoregion :: .align
@Naporon2start:
	.include "asm/scriptcode/naporon/naporon2start.asm"
.endautoregion
.autoregion :: .align
@Naporon2lose:
	.include "asm/scriptcode/naporon/naporon2lose.asm"
.endautoregion
.autoregion :: .align
@Naporon2redo:
	.include "asm/scriptcode/naporon/naporon2redo.asm"
.endautoregion
.autoregion :: .align
@Naporon2win:
	.include "asm/scriptcode/naporon/naporon2win.asm"
.endautoregion
.autoregion :: .align
@Naporon3start:
	.include "asm/scriptcode/naporon/naporon3start.asm"
.endautoregion
.autoregion :: .align
@Naporon3lose:
	.include "asm/scriptcode/naporon/naporon3lose.asm"
.endautoregion
.autoregion :: .align
@Naporon3redo:
.endautoregion
.autoregion :: .align
	.include "asm/scriptcode/naporon/naporon3redo.asm"
.endautoregion
.autoregion :: .align
@Naporon3win:
	.include "asm/scriptcode/naporon/naporon3win.asm"
.endautoregion
.autoregion :: .align
@Baron1start:
	.include "asm/scriptcode/baron/baron1start.asm"
.endautoregion
.autoregion :: .align
@Baron1lose:
	.include "asm/scriptcode/baron/baron1lose.asm"
.endautoregion
.autoregion :: .align
@Baron1redo:
	.include "asm/scriptcode/baron/baron1redo.asm"
.endautoregion
.autoregion :: .align
@Baron1win:
	.include "asm/scriptcode/baron/baron1win.asm"
.endautoregion
.autoregion :: .align
@Baron2start:
	.include "asm/scriptcode/baron/baron2start.asm"
.endautoregion
.autoregion :: .align
@Baron2lose:
	.include "asm/scriptcode/baron/baron2lose.asm"
.endautoregion
.autoregion :: .align
@Baron2redo:
	.include "asm/scriptcode/baron/baron2redo.asm"
.endautoregion
.autoregion :: .align
@Baron2win:
	.include "asm/scriptcode/baron/baron2win.asm"
.endautoregion
.autoregion :: .align
@Baron3start:
	.include "asm/scriptcode/baron/baron3start.asm"
.endautoregion
.autoregion :: .align
@Baron3lose:
	.include "asm/scriptcode/baron/baron3lose.asm"
.endautoregion
.autoregion :: .align
@Baron3redo:
	.include "asm/scriptcode/baron/baron3redo.asm"
.endautoregion
.autoregion :: .align
@Baron3win:
	.include "asm/scriptcode/baron/baron3win.asm"
.endautoregion
.autoregion :: .align
@Baron3winlast:
	.include "asm/scriptcode/baron/baron3winlast.asm"
.endautoregion
.autoregion :: .align
@Intermission:
	.include "asm/scriptcode/intermission.asm"
.endautoregion
.autoregion :: .align
@NewEndingScript:
	.include "asm/scriptcode/ending.asm"
.endautoregion
.autoregion :: .align
@TeacherHareRankUpWorld1:
    .include "asm/scriptcode/rankup/rankup_hare1.asm"
.endautoregion
.autoregion :: .align
@TeacherHareRankUpWorld2:
    .include "asm/scriptcode/rankup/rankup_hare2.asm"
.endautoregion
.autoregion :: .align
@TeacherHareRankUpWorld3:
    .include "asm/scriptcode/rankup/rankup_hare3.asm"
.endautoregion
.autoregion :: .align
@TeacherHareRankUpWorld4:
    .include "asm/scriptcode/rankup/rankup_hare4.asm"
.endautoregion
.autoregion :: .align
@BaronMagicRankUpWorld1:
    .include "asm/scriptcode/rankup/rankup_baron1.asm"
.endautoregion
.autoregion :: .align
@BaronMagicRankUpWorld2:
    .include "asm/scriptcode/rankup/rankup_baron2.asm"
.endautoregion
.autoregion :: .align
@BaronMagicRankUpWorld3:
    .include "asm/scriptcode/rankup/rankup_baron3.asm"
.endautoregion
.autoregion :: .align
@BaronMagicRankUpWorld4:
    .include "asm/scriptcode/rankup/rankup_baron4.asm"
.endautoregion
.autoregion :: .align
@DadRankUp1:
    .include "asm/scriptcode/rankup/rankup_dad1.asm"
.endautoregion
.autoregion :: .align
@DadRankUp2:
    .include "asm/scriptcode/rankup/rankup_dad2.asm"
.endautoregion
.autoregion :: .align
@DadRankUp3:
    .include "asm/scriptcode/rankup/rankup_dad3.asm"
.endautoregion
.autoregion :: .align
@DadRankUp4:
    .include "asm/scriptcode/rankup/rankup_dad4.asm"
.endautoregion
.autoregion :: .align
MinigameUnlock:
	.include "asm/scriptcode/minigameunlock.asm"
.endautoregion
.autoregion :: .align
MagicUnlock:
	.include "asm/scriptcode/magicunlock.asm"
.endautoregion