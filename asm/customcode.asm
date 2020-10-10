	
.org 0x080B0000 ; Free space to add my "hook" (+ original parser)
	.area 0x8000
		cmp r0,0Fh ; "06 00 0F 00" is my custom command
		beq addVW
		 ; Default command after here (original)
		lsl r0,r0,2h
		ldr r1,=0x0801F014
		add r0,r0,r1
		ldr r0,[r0]
		mov r15,r0 
	.pool

	CmdParse2: ;code from x080210C0 - here, 0x14 OR 0x1A leads to script parsing
		cmp r0,1Ah
		bne NormalExec
		;special
		mov r4,r0 ;highly unlikely r4 would equal 0x1A by chance
		mov r0,14h
	NormalExec: ; original code
		lsl r0,r0,2h
		ldr r1,=0x080210D0
		add r0,r0,r1
		ldr r0,[r0]
		mov r15,r0 ;if r0 was 0x14, should lead to ScriptParse
	.pool

	addVW: 
		;some RAM stuff to load x-cood into r0
		ldr r0,[r4,30h]
		lsl r1,r5,2h ;r5 = 0x12 or 0x14
		add r1,r1,r0
		ldr r0,[r1] ; TODO: Modify this x-coordinate
		
		;new: set x-coord aside
		mov r7,r0
		
		ldr r0,[r4,30h]
		mov r2,r5
		sub r2,12h ; need 0x12 to return 0x20, 0x14 to return 0x2C
		mov r3,r2
		lsl r2,r2,2h
		lsl r3,r3,1h
		add r2,r2,r3
		add r2,20h
		ldrh r0,[r0,r2]		; Relative offset for current character (only halfword)

		lsr r0,r0,5h	;some bit-shifting due to how I put in my width table
		lsl r0,r0,1h
		
		mov r3,r0
		ldr r0,=WidthTable
		ldrb r0,[r0,r3]
		
		add r0,r0,r7
		str r0,[r1]
		
		;Original Code
		;add r0,r0,r6
		;str r0,[r1]
		ldr r0,=0x0801F1B6+1
		mov r2,r0
		bx r2

	.pool
	.align 4

	;Code to repoint script parser (old pointer - 0x080216AC
	ScriptParse:
		;new - use r12 to store loc of x-coord
		mov r1,r12
		push r1
		;new - 0x12 for scrolling text, 0x14 non-scrolling
		mov r1,r4
		cmp r1, 1Ah
		beq R1To14
		ldr r1, =12h
		b StoreToR12
		R1To14:
		ldr r1, =14h
		b StoreToR12
		.pool
		StoreToR12:
		mov r12,r1
		mov r1,r8 ;original code	
		add r1,4h
		mov r0,r7
		bl 0x0801EBAC ;sets where in RAM to put char offsets
		mov r4,r0
		add r6,r4,1h
		mov r1,r8
		;ldrh r3,[r1,8h] ;this loads the char - new code ahead - have a pointer ;to where the text should go
			ldr r2,[r1,0x0C] ;points to next script to parse
			mov r9,r2
			ldr r3,[r1,8h]
			mov r10,r3 ;storing - end of new code
			
			mov r2,0h	;new - use r11 to store a running total of total width of characters
			mov r11,r2
			
			ldrh r3,[r3] ;points to next char within script pointer
			mov r2, 2h
			add r10,r2
		lsl r0,r3,10h
		;mov r2,0Ah
		;add r2,r8
		;mov r9,r2
		cmp r0,0h
		beq DoneWithText ; need to change
		lsl r1, r6, 2h
		mov r8, r1
	NextChar:
		lsr r0, r0, 18h
		lsl r1, r3, 8h
		orr r0, r1
		lsl r0, r0, 10h
		lsr r3, r0, 10h
		ldr r0, =0x81AB 
		cmp r3, r0
		bne Check1
		ldr r0, [r7, 30h]
		add r0, r8
		mov r1, 2h
		neg r1, r1
		str r1, [r0, 0h]
		b Branch2
	.pool
	Check1:
		ldr r0, =0x843F 
		cmp r3, r0
		bls Check2
		mov r0, r3
		bl 8023148h
		mov r5, r0
		ldr r0, [r7, 30h]
		mov r1, r8
		add r2, r1, r0
		mov r0, 1h
		neg r0, r0
		cmp r5, r0
		beq Cond1
		ldr r0, =0x3005848 
		ldr r1, [r0, 0h]
		lsl r0, r5, 2h
		b Branch1
	.pool
	Cond1:
		str r5, [r2, 0h]
		b Branch2
	Check2:
		ldr r0, =0x833F 
		cmp r3, r0
		bls Check3
		ldr r2, [r7, 30h]
		add r2, r8
		ldr r0, =0x3005858 
		ldr r1, [r0, 0h]
		lsl r0, r3, 2h
		add r0, r0, r1
		ldr r1, =0xFFFDF300 
		b Branch1
	.pool
	Check3:
		ldr r0, =0x823F
		cmp r3, r0
		bls Check4
		ldr r2, [r7, 30h]
		add r2, r8
		ldr r0, =0x300585C 
		ldr r1, [r0, 0h]
		lsl r0, r3, 2h 
		add r0, r0, r1 
		ldr r1, =0xFFFDF700 
		b Branch1
	.pool
	Check4:
		ldr r0, =0x813F 
		cmp r3, r0
		bls Branch2
		ldr r2, [r7, 30h]
		add r2, r8
		ldr r0, =0x3005850 
		ldr r1, [r0, 0h]
		lsl r0, r3, 2h
		add r0, r0, r1
		ldr r1, =0xFFFDFB00 
		b Branch1
	.pool
	Branch1:
		add r0, r0, r1
		ldr r0, [r0] ;<---LOADING OF RELATIVE OFFSETS
		str r0, [r2] ;<---STORAGE OF RELATIVE OFFSETS
		
		;new - add corresponding width from width table to r11
		ldrh r0, [r2]
		lsr r0, r0,5h	;some bit-shifting due to how I put in my width table
		lsl r0, r0,1h
		mov r1, r0
		ldr r0, =WidthTable
		ldrb r0, [r0,r1]
		mov r1, r11
		add r0, r0, r1
		mov r11, r0
		b Branch2
	.pool
	Branch2:
		mov r2, 4h
		add r8, r2
		add r6, 1h
			mov r0, r10	;the mov
		ldrh r3, [r0, 0h]
		lsl r0, r3, 10h
			mov r1, 2h ; increment
		;add r9, r1
			add r10, r1
		cmp r0, 0h
		bne NextChar 
	DoneWithText: ;all done with text
		ldr r0, [r7, 30h]
		lsl r1, r4, 2h
		add r1, r1, r0
		sub r0, r6, r4
		sub r0, 1h
		str r0, [r1] ;store number of chars?
		bl WriteNewX
		mov r0, r9
		add r0, 3h
		;restore r12
		add sp,4h
		pop r1
		mov r12,r1
		
		mov r1, 4h
		neg r1, r1
		and r0, r1
		
		;readjust stack
		pop r3-r4
		mov r8,r3
		mov r9,r4
		pop r4-r7
		pop r1
		bx r1

	WriteNewX:
		;new - overwrite x-coordinate with new one calculated from r11
		mov r1, r11
		ldr r0, =0xF0
		sub r1, r0, r1
		lsr r1, 1h		;calc new x coordinate

		ldr r0, [r7, 30h]
		mov r3,r0
		mov r0,r12
		lsl r0,r0,2h
		add r0,r0,r3
		strb r1,[r0]
		bx r14
		.pool
WidthTable:
.incbin "bin/width.bin"

InstaText:	;pls work
.include "asm/vwfInstaText.asm"

.word 0x00000000
;generates an additional DMA transfer to get custom
;Minigame Paradise titles in the Obj VRAM
MiniParaTitleHook:
		push r14
		bl 0x08092030
		ldr r0, =MiniParaTitles
		ldr r2, =0x1A20
		ldr r1, =0x060128E0
		bl 0x08092030
		pop r1
		bx r1
		.pool

;custom hook to load minigame titles as 32x8 objs instead of 8x8
CreateMiniParaTitleObjs:
	;r0 = x, r1 = y, r3 = pal, r4 = order from top of list
	push r4-r7,r14
	mov r7,r10
	mov r6,r9
	mov r5,r8
	push r5-r7
	add sp,-8h
	mov r5,r0
	mov r0,0x00
	mov r10,r0
	sub r0,0x08
	cmp r1,r0
	bgt @MinYPassed
	b @EndSubroutine
@MinYPassed:
	cmp r1,0x9F
	ble @YInBounds
	b @EndSubroutine
@YInBounds:
	mov r6,0xFF
	mov r9,r6
	mov r0,r9
	and r0,r1 ;gets rid of additional bits greater than 0xFF
	mov r9,r0
	
	lsl r1,r3,0x0C ;OAM bit handling palette
	
	ldr r0,=0x030038C4
	ldrb r0,[r0] ;obj bank
	lsr r0,r0,0x02
	lsl r0,r0,0x0A
	orr r1,r0 ;obj priority - makes text appear on top of BG1
	lsl r1,r1,0x10
	lsr r1,r1,0x10
	mov r8,r1 ;save for later
	b CheckObjCount
	.pool
	ReadMinigameID:
	;update cooresponding tiles obj needs to refer to
	mov r1,r4
	lsl r0,r1,0x01
	add r0,r0,r1
	lsl r0,r0,0x02 ;times 12
	ldr r1,=0x147
	add r0,r0,r1
	mov r7,r0
	
	mov r1,r10
	sub r1,r1,0x01
	lsl r0,r1,0x02
	mov r1,r7
	add r0,r0,r1
	mov r7,r0 ;update tile #
	;check if x-coord is in bounds
	mov r0,0x20
	neg r0,r0
	cmp r5,r0
	ble IncrementX
	
	;code to update obj bank
	ldr r0,=0x030038C4
	ldrb r0,[r0]
	str r3,[sp]
	bl 0x080922D4
	mov r2,r0
	ldr r3,[sp]
	cmp r2,0x00
	beq @EndSubroutine
	;OAM Attribute 1 (2nd one, 1st one is Attr 0)
	lsl r0,r5,0x10 ;x-coord
	ldr r1,=0x1FF0000
	and r0,r1 ;only bits 0-8 coorespond to x-coordinate (16-24 here)
	mov r1,0x01
	lsl r1,r1,0x1E
	orr r0,r1 ;sets size
	mov r1,0x01
	lsl r1,r1,0x0E
	orr r0,r1 ;sets shape to horizontal
	mov r1,r9 ;y-coord
	orr r0,r1
	str r0,[r2]
	
	;OAM Attr 2
	mov r0,r8
	orr r0,r7
	strh r0,[r2,0x04]
	IncrementX:
	mov r0,0x20
	add r5,r5,r0 ;change x coord
	b CheckObjCount
	.pool
	CheckObjCount:
	mov r0,r10 ;0x00 by default
	add r0,r0,0x01
	cmp r0,0x03
	bgt @EndSubroutine
	mov r10,r0
	b ReadMinigameID
	
	@EndSubroutine:
	add sp,0x08
	pop r3-r5
	mov r8,r3
	mov r9,r4
	mov r10,r5
	pop r4-r7
	pop r0
	bx r0
.endarea

MenuAddVW:
	;r4 contains text, r5 contains x-coord
	cmp r4, 0h
	beq @NullPtr
	push r0
	push r1
	sub r4, r4, 2h
	ldrh r2,[r4] ;get current character
	
	;reverse the bytes (mimic 0x080231C4)
	mov r0, r2
	lsr r0, r0, 8h
	lsl r1, r2, 8h
	orr r0, r1
	lsl r0, r0, 10h
	lsr r2, r0, 10h ;r2 contains reversed bytes
	
	;PARTIAL, it's a hack
	ldr r0, =0x833F
	cmp r2, r0
	bls @MCheck2
	
	ldr r0, =0x3005858
	ldr r1, [r0]
	lsl r0, r2, 2h
	add r0, r0, r1
	ldr r1, =0xFFFDF300
	b @MBranch1
	.pool
	
	@MCheck2:
		ldr r0, =0x823F
		cmp r2, r0
		bls @MCheck3
		
		ldr r0, =0x0300585C
		ldr r1, [r0]
		lsl r0, r2, 2h
		add r0, r0, r1
		ldr r1, =0xFFFDF700
		b @MBranch1
		.pool
		
	@MCheck3:
		;ldr r0, =0x813F not really a check lol
		ldr r0, =0x03005850
		ldr r1, [r0]
		lsl r0, r2, 2h
		add r0, r0, r1
		ldr r1, =0xFFFDFB00
		b @MBranch1
		.pool
	
	@MBranch1:
		add r0, r0, r1
		ldr r2, [r0] ;<-- The relative offset I need!! (just chop off the 1st 16 bits)
		
		lsl r0, r2, 0x10
		lsr r0, r0, 0x10
		;new - add corresponding width from width table to r11
		lsr r0, r0,5h	;some bit-shifting due to how I put in my width table
		lsl r0, r0,1h
		mov r1, r0
		ldr r0, =WidthTable
		ldrb r0, [r0,r1] ;r0 contains width!!!
		
		add r5, r5, r0
		add r4, 2h
		
		pop r1
		pop r0
@MRead:
		ldrh r2, [r4]
@NullPtr:	
		bx r14
		.pool
		
		
	
	