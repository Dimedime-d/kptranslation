 ; Attempt to formulate a variable-width font in Kururin Paradise
 
.org 0x08023118
    b 0x08023126 ; unconditional jump skips counting kanji
 
.org 0x08021680	;repoint to other character bank!
.area 0x080216AC - 0x08021680
	; table of relative offsets, 1st one's punctuation
	ldr r0,=0x08039808 ; new! old: 0x08039128
	ldr r1,=0x08039B08 ; new! (altfont) old: 0x080392A8 (tbl for hiragana/English)
	ldr r2,=0x08039570 ; katakana
	ldr r3,=0x080396CC ; kanji
	ldr r4,=0x0803979C ; table of valid kanji id's
	str r4,[sp]
	bl 0x080230F8 ; function that sets fonts
	
	mov r0,r8
	add r0,4h
	b 0x080218DA
.pool
.endarea
					
.org 0x0801EFFE ; Edited parser
.area 4h
	cmp r0,0Fh ; 0x0F custom code
	bls 0x0801F004
.endarea		

.org 0x0801F004 
	.area 4h
	bl 0x080B0000 ; new branch
.endarea

.org 0x080210B8
.area 4h
	cmp r0,1Ah ; 1A custom code to center text
	bls 0x080210C0
.endarea

.org 0x080210C0
.area 4h
	bl CmdParse2 ; new branch
.endarea

.org 0x08021120 ;pointer to script parser
	.word ScriptParse

.org 0x08014706 ; practice mode, A button on a magic hat (normally does nothing)
.area 4h
    bl InitPracticeCutsceneMenu
.endarea
	
.org 0x080145da ; practice mode state check
.area 4h
    bl PracticeStateRepoint
.endarea

.org 0x08022A18 ; magic state 5 - initialize data for Learn screen
.area 6h
    bl MagicLearnInitHook
    b 0x08022b88
.endarea

.org 0x08022950 ; ; re-wire BG1 preparation + DMA the palettes
.area 4h
    bl MagicLearnBG1PrepHook
.endarea

.org 0x08022B90
    nop ; stops overwriting new page position
    
.org 0x08022BAE
    mov r3, 0xFA ; originally E8, this enables BG1
    
.org 0x08022BE2
    nop ; originally sub r1, 0x06 (determines maximum scrolling boundary)
    
.org 0x08022BEC
    bl MagicLearnCursorHook
    
.org 0x08022C38 ; magic state 6 - responsible for updating text/images
.area 6h
    bl MagicLearnDisplayHook
    b 0x08022CD4
.endarea
