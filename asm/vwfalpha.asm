 ; Attempt to formulate a variable-width font in Kururin Paradise
.org 0x08800000	;padding to extend the ROM
.region 0x0800000,00
.endregion
 
.org 0x08021680	;repoint to other character bank!
.area 0x080216AC - 0x08021680
	ldr r0,=0x08039128
	ldr r1,=0x08039B08 ; new! (altfont) old: 0x080392A8
	ldr r2,=0x08039570
	ldr r3,=0x080396CC
	ldr r4,=0x0803979C
	str r4,[sp]
	bl 0x080230F8
	
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

.org 0x082ed78c
.incbin "bin/2ed78c.bin" ;fixes x-pos of each character

.org 0x08039128
	.incbin "bin/punct.bin" ;repoints punctuation

.org 0x08039250
	.incbin "bin/punct2.bin" ;repoints duplicate degree sign, apostrophe & quote marks

.org 0x08039190
	.incbin "bin/punct3.bin" ;repoints tilda


	
