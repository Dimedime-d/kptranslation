	
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
		ldr r0,[r0,r2]		; Relative offset for current character (relative to 0x284F70)

		bl RelOffsetToWidth
		
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
        mov r1, r8
        push r1 ; store original bytecode location
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
		mov r2, 0h
		mov r11, r2 ; store width running total
        
		mov r12,r1
		mov r1,r8 ;original code - r8 stores script location
		add r1,4h
		mov r0,r7
		bl 0x0801EBAC ;sets where in RAM to put char offsets
		mov r4,r0
		add r6,r4,1h
		mov r1,r8
		ldrh r3,[r1,8h] ;NEW - this used to contain the string (char), now it contains a text ID
            lsl r3,r3,2h
            ldr r0, =DialogueTable
            add r0,r3
            ldr r0,[r0] ; r0 now contains pointer to string
            ldrh r3,[r0,0h] ; new location of char
            
            add r0,2h
            mov r9,r0 ; r9 stores location of the next char
        ; r3 should still contain the char
		lsl r0,r3,10h
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
		
		bl RelOffsetToWidth
        
		mov r1, r11 ; running tally of sum of x-coordinates, to auto-center text
		add r0, r0, r1
		mov r11, r0
		b Branch2
	.pool
	Branch2:
		mov r2, 4h
		add r8, r2
		add r6, 1h
			mov r0, r9	;the mov
		ldrh r3, [r0, 0h]
		lsl r0, r3, 10h
			mov r1, 2h ; increment
		add r9, r1
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
		pop r0
        add r0, 0x0C ; bytecode command is now fixed size
		;restore r12
		add sp,4h
		pop r1
		mov r12,r1
		
		mov r1, 4h
		neg r1, r1
		and r0, r1 ;align r0 to 4 bytes
		
		;readjust stack
		pop r3-r4
		mov r8,r3
		mov r9,r4
		pop r4-r7
		pop r1
		bx r1

	WriteNewX:
		;new - overwrite x-coordinate with new AUTO-CENTERED one calculated from r11
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
        .align

InstaText:	;pls work
.include "asm/scriptcode/vwfInstaText.asm"

.word 0x00000000
.pool
.align

SfxParseHook1:
    ; overwritten asm: mov r3, r8; ldrh r2, [r3, 8h]
    ; lsl r0, r2, 10h; adds r3, 0x0A
    mov r3, r8
    push r3
    ldrh r2, [r3, 8h] ; at the end, r2 should contain char, r3 the pointer to the next char
    ; r0 is free
    lsl r2, r2, 2h ; should now be a text ID
    ldr r0, =DialogueTable
    add r0,r2
    ldr r0, [r0]
    ldrh r2, [r0, 0h]
    add r3, r0, 2h
    bx r14
   
SfxParseHook2:
    ; overwritten asm: adds r0, r3, 3h; subs r1, 4h; and r0, r1
    pop r0 ; the r8 from the above hook
    add r0, 0Ch
    sub r1, 4h ; r1 contained 0
    and r0, r1 ; 4-aligns r0
    bx r14
    
.pool
.align
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
;subroutine REPLACES one that parses ASCII (0x08094144)
CreateMiniParaTitleObjs:
	;r0 = x, r1 = y, r3 = pal, r4 = order from top of list
	push r4-r7,r14
	mov r7,r10
	mov r6,r9
	mov r5,r8
	push r5-r7
	add sp,-8h
	mov r5,r0 ; now r5 contains x-coordinate
	mov r0,0x00
	mov r10,r0  ; zero out r10 for later (obj count check)
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
	and r0,r1 
	mov r9,r0 ; r9 contains (y-coordinate & 0xFF)
	
	lsl r1,r3,0x0C ;OAM nibble handling palette (Attribute 2, bits 12-15)
	
	ldr r0,=0x030038C4
	ldrb r0,[r0] ;obj bank
	lsr r0,r0,0x02
	lsl r0,r0,0x0A
	orr r1,r0 ;obj priority - makes text appear on top of BG1
	lsl r1,r1,0x10
	lsr r1,r1,0x10
	mov r8,r1 ; r8 contains obj priority (OAM Attribute 2, bits 10-11) and palette
	b CheckObjCount
	.pool
	ReadMinigameID:
	;update cooresponding tiles obj needs to refer to
	mov r1,r4
	lsl r0,r1,0x01
	add r0,r0,r1
	lsl r0,r0,0x02 ;minigame index times 12
	ldr r1,=0x147
	add r0,r0,r1
	mov r7,r0 ;
	
	mov r1,r10
	sub r1,r1,0x01
	lsl r0,r1,0x02
	mov r1,r7
	add r0,r0,r1
	mov r7,r0 ; r7 contains tile number (OAM Attribute 2, bits 0-9)
    ; taking into account minigame index and current iteration (r10)
    
	; check if x-coord is in bounds
	mov r0,0x20
	neg r0,r0
	cmp r5,r0
	ble IncrementX
	
	;code to update obj bank
	ldr r0,=0x030038C4
	ldrb r0,[r0]
	str r3,[sp]
	bl 0x080922D4 ; some function that updates an object slot
    ; returns an address where I can store my OAM attributes into r0
	mov r2,r0
	ldr r3,[sp]
	cmp r2,0x00
	beq @EndSubroutine ; check invalid object pointer
    
	;OAM Attribute 1 (2nd one, 1st one is Attr 0)
    ;r0 is to contain OAM attributes 0 and 1
	lsl r0,r5,0x10 ;x-coord
	ldr r1,=0x1FF0000
	and r0,r1 ; r0 contains: x-coordinate (OAM Attribute 1, bits 0-8, which are bits 16-24 here)
	mov r1,0x01
	lsl r1,r1,0x1E
	orr r0,r1 ; fixed object size (OAM Attribute 1, bits 14-15 [bits 30-31]) Here, size = 1...
	mov r1,0x01
	lsl r1,r1,0x0E
	orr r0,r1 ; 1 = horizontal shape (OAM Attribute 0, bits 14-15)
	mov r1,r9 ;y-coord
	orr r0,r1 ; r0 also contains: y-coordinate (OAM Attribute 0, bits 0-8)
	str r0,[r2] ; finally store the first 2 OAM attributes to that object slot
	
	;OAM Attr 2
	mov r0,r8
	orr r0,r7 
	strh r0,[r2,0x04] ; store all of OAM attribute 2 into object slot
    
	IncrementX:
	mov r0,0x20
	add r5,r5,r0 ;change x coord
	b CheckObjCount
	.pool
	CheckObjCount:
	mov r0,r10
	add r0,r0,0x01
	cmp r0,0x03 ;want to draw three objects per line (that's the graphics space I allocated to each minigame title)
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

MenuAddVW:
	;r4 contains text, r5 contains x-coord
	cmp r4, 0h
	beq @NullPtr
    push r14
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
		ldr r0, =0x813F
		cmp r2, r0
        bls @MFallthrough

        ldr r0, =0x03005850
		ldr r1, [r0]
		lsl r0, r2, 2h
		add r0, r0, r1
		ldr r1, =0xFFFDFB00
		b @MBranch1
		.pool
	
    @MFallthrough:
        mov r0, 0x00 ; other characters are zero width
        b @MAddWidth
        
	@MBranch1:
		add r0, r0, r1
		ldr r2, [r0] ;<-- The relative offset I need!! 
		mov r0, r2
		bl RelOffsetToWidth
        
	@MAddWidth:
		add r5, r5, r0
		add r4, 2h
		
		pop r1
		pop r0
        
		ldrh r2, [r4]
        pop r14 ; effectively pop r15
@NullPtr:	
		bx r14
		.pool
		.align
        
RelOffsetToWidth:
    ; enough bit-shifting nonsense,
    ; just subtract 2E4EB4 - 284F70 from the whole offset,
    ; then divide by 0x88, and there's your width...
	push r1
	ldr r1, =0x5FF44
    sub r0, r0, r1
    mov r1, 0x88
    swi 06
    mov r1, r0
	ldr r0, =NewWidthTable
	ldrb r0, [r0,r1]
	pop r1
	bx r14
	.pool
    .align
    
InitPracticeCutsceneMenu:
    ; basically just copy 08014728 (open up in No$gba to avoid stack errors...)
    ; TODO - not allow menu selection if magic hat isn't beaten yet
    push r14
    sub sp, 0x04
    ; logic to check cleared here
    ldr r1, =0x030005a0
    add r1, 0x90
    ldr r0, [r1] ; current SRAM ptr
    mov r1, 0xc2
    lsl r1, r1, 0x01
    add r0, r0, r1
    add r0, r0, r7 ;get byte corresponding to minigame status
    ldrb r0, [r0]
    lsl r0, r0, 0x18
    asr r0, r0, 0x18
    cmp r0, 0x01
    bgt @@MinigameBeaten
    mov r0, 0x50
    bl 0x0803CF44
    b @InitEnd
    
    @@MinigameBeaten:
    mov r0, 0x34
    bl 0x0803CF44 ; sfx
    
    ldr r0, =RenderPracticeCutsceneMenu+1
    str r0, [sp, 0x10]
    mov r1, sp
    mov r0, 0x04 ; know the max size of menu
    strb r0, [r1, 0x08]
    mov r0, sp
    strb r6, [r0, 0x09] ; r6 = 0x01 (default selection happens to be sub-state)
    mov r5, sp
    ; retrieve coords of level id
    ldr r2, =0x0802E28C ; OW x coords
    lsl r3, r7, 0x02 ; r7 contains level id
    add r0, r3, r2
    ldrb r1, [r0] ; raw x-coord
    ldr r4, =0x030053A0
    ldr r0, [r4, 0x10]
    add r0, 0x30
    sub r1, r1, r0
    strb r1, [r5, 0x0a] ; store x-coord
    add r2, 0x02 ; y coords are offset
    add r3, r3, r2
    ldrb r1, [r3]
    ldr r0, [r4, 0x14]
    add r0, 0x20
    sub r1, r1, r0
    strb r1, [r5, 0x0b] ; store y-coord
    mov r6, 0x03 ; !! custom state
    
    @InitEnd:
    add sp, 0x04
    pop r0
    bx r0
    .pool
    .align

PracticeStateRepoint:
    push r14
    mov r0, r14
    cmp r6, 0x02
    bne @@StateNot2
    pop r0
    bx r0 ; resume execution at original location if state 0x02
    @@StateNot2:
    cmp r6, 0x03
    beq @@State3
    ; default case...
    @@Exit:
    pop r0
    add r0, 0x02
    bx r0 ; kinda scuffed but that's how the code's laid out in the original location
    @@State3:
        ; copy 0x080147C8, EXCEPT what happens on a/start press
        bl 0x080921E8
        bl 0x08092748
        ldr r4, =0x030005A0
        mov r2, 0x84
        lsl r2, r2, 0x01
        add r0, r4, r2
        ldr r0, [r0, 0x00] ; 030006a8
        mov r1, 0x02
        and r0, r1
        cmp r0, 0x00
        beq @@DefaultBranch
        ldr r2, =0x03000040
        ldrh r0, [r2, 0x00]
        mov r3, 0x80
        lsl r3, r3, 0x01
        add r1, r3, 0x00
        orr r0, r1
        strh r0, [r2, 0x00] ; DISPCNT |= 0x100
        add r0, r4, 0x00
        add r0, 0x4c
        ldrh r1, [r0, 0x00] ; key press mask
        mov r0, 0x02
        and r0, r1
        cmp r0, 0x00
        beq @@NoBPress
        ; B Press cancels...
        mov r0, 0x35
        bl 0x0803CF44
        mov r6, 0x01
        b @@DefaultBranch
        .pool
        .align
        
        @@NoBPress:
        mov r0, 0x09
        and r0, r1
        cmp r0, 0x00
        beq @@DefaultBranch
        ; on A/start press, add implementation here!! (reality: check if ctrl flag 0x04 bit is set below, this delays the cutscene trigger until after the transition is finished)
        
        ; r7 contains level id
        ldr r0, =0x030005a0
        add r0, 0x90
        ldr r2, [r0, 0x00]
        ldr r0, =0x1F3
        add r0, r2, r0
        mov r1, r7
        strb r1, [r0, 0x00] ; store current level id in SRAM
        
        ldr r0, =0x08001C25
        mov r1, 0x08
        bl 0x080944AC ; fadeout object
        
    @@DefaultBranch:
        ldr r2, =0x030005a0
        mov r1, 0x84
        lsl r1, r1, 0x01
        add r0, r2, r1
        ldr r1, [r0, 0x00]
        mov r0, 0x04
        and r1, r0
        cmp r1, 0x00
        bne @@TimeToLoadScript
        b @@Continue
        
            @@TimeToLoadScript:            
            ; Logic for selecting which script (01 = start, 02 = lose, 03 = retry, 04 = win)
            ; [sp+0x05] contains menu option
            mov r1, sp
            ldrb r0, [r1, 0x05]
            sub r0, r0, 0x01
            cmp r0, 0x04
            bge @@ExecuteScript
            ldr r1, =@@MenuMusicLookup
            ldrb r0, [r1, r0]
            bl 0x0800A1B8
            
            mov r1, sp
            ldrb r0, [r1, 0x05]
            mov r3, r0
            
            mov r1, 0x01
            and r0, r1 ;even/odd check
            cmp r0, 0x00
            beq @@LoseWin
            ; start/retry
            lsr r0, r3, 0x01 ; 00 = start, 01 = retry
            lsl r3, r0, 0x02 ; r3 now contains 00 or 04
            mov r2, r7
            sub r2, 0x2a
            ldr r1, =0x030005a0
            add r1, 0x90 ;630 save file data pointer
            ldr r0, [r1]
            ldr r1, =0x1df ; some lookup to decide cutscenes
            add r0, r0, r1
            add r0, r0, r2
            ldrb r0, [r0, 0x00]
            lsl r0, r0, 0x03
            add r0, r0, r3
            ldr r1, =StartRetryArray
            add r1, r1, r0
            ldr r0, [r1, 0x00] ; get script
            b @@ExecuteScript
            @@LoseWin:
            lsr r0, r3, 0x02 ; 00 = lose, 04 = win
            lsl r3, r0, 0x02
            mov r2, r7
            sub r2, 0x2a
            ldr r1, =0x030005a0
            add r1, 0x90
            ldr r0, [r1]
            ldr r1, =0x1df
            add r0, r0, r1
            add r0, r0, r2
            ldrb r0, [r0, 0x00]
            lsl r0, r0, 0x03
            add r0, r0, r3
            ldr r1, =LoseWinArray
            add r1, r1, r0
            ldr r0, [r1, 0x00]
            mov r4, r0
            ; extra logic to write the minigame/magic unlocked
            ldr r1, =0x0802e514
            mov r0, r7
            mov r2, r0
            sub r2, 0x2a
            add r0, r2, r1
            ldrb r0, [r0, 0x00] ; proper minigame id
            sub r0, r0, 0x01
            ldr r1, =0x030005a0
            add r1, 0x95
            mov r3, r1
            strb r0, [r1, 0x00] ; store minigame unlocked
            ldr r1, =0x0802ea90
            add r0, r2, r1
            ldrb r0, [r0, 0x00]
            mov r1, r3
            strb r0, [r1, 0x01]
            
            mov r0, r4
            ldr r1, =Baron3Win
            ldr r1, [r1]
            sub r0, r0, r1
            cmp r0, 0x00
            bne @@NotBaron3
            ldr r1, =0x030005a0
            add r1, 0xa0
            ldrb r0, [r1]
            cmp r0, 0x00
            beq @@LastBaron
            cmp r0, 0x01
            beq @@PlayLastBaronAllMagic
            b @@PlayNeoLand
            
            @@LastBaron:
            mov r2, r1
            ldr r1, =0x030005A0
            add r1, 0x90
            ldr r0, [r1]
            add r0, 0x0e
            ldrh r0, [r0]
            ldr r1, =0xFFF
            and r0, r1
            cmp r0, r1
            bne @@PlayLastBaron
            mov r0, 0x01
            mov r1, r2
            strb r0, [r1]  ;the increment that lets you re-watch pre-neo land cutscenes
            @@PlayLastBaron:
            mov r0, r4
            b @@ExecuteScript
            @@PlayLastBaronAllMagic:
            mov r0, 0x02
            strb r0, [r1]
            ldr r0, =LastBaronWin
            ldr r0, [r0]
            b @@ExecuteScript
            @@PlayNeoLand:
            mov r0, 0x00
            strb r0, [r1]
            mov r0, 0x18
            bl 0x0800A1B8
            ldr r0, =NeoLandCutscene
            ldr r0, [r0]
            b @@ExecuteScript
            
            @@NotBaron3:
            mov r0, r4
            @@ExecuteScript:
            mov r1, 0x08
            mov r2, 0x01
            mov r3, 0x04
            bl 0x08014324 ; execute script
            
            @@Cleanup:
            ; post-script cleanup - reset the practice world state
            mov r0, 0x00
            ldr r1, =0x030005a0
            add r1, 0x95
            strb r0, [r1, 0x00] ;zero out unlocked minigame/magic
            strb r0, [r1, 0x01] ;zero out unlocked minigame/magic
            mov r6, r0
    
    @@Continue:
    ldr r4, =0x030005A0
    mov r1, 0x84
    lsl r1, r1, 0x01
    add r0, r4, r1
    ldr r0, [r0, r0] ;030006a8
    mov r1, 0x04
    and r0, r1
    cmp r0, r0
    beq @@DontExit
    ldr r6, =0xFFFFFFFF; this exits practice mode, I think
    @@DontExit:
    add r0, r7, 0x00
    bl 0x08014020 ; draw OW Sidebar and Map
    add r0, r4, 0x00
    add r0, 0x4c
    ldrh r1, [r0, 0x00]
    mov r0, sp
    add r0, r0, 0x04
    mov r2, 0x33
    bl 0x080945BC ; menu scroll listen
    bl 0x08094530 ; update objects?
    bl 0x08092754 ; prep DMA of object tiles
    bl 0x0809221C ; update OAM mirror?
    
    b @@Exit
    
    .pool
    .align
@@MenuMusicLookup:
    .byte 0x18, 0x1e, 0x18, 0x1d
    
RenderPracticeCutsceneMenu:
    ;TODO - parse ASCII + textbox for cutscene menu
    push {r4, r5, lr} ; r0 has info about the menu, r1 dictates what gets drawn
    sub sp, 0x04
    ;copy 0x080148d4, pretty much
    add r4, r0, 0x00
    mov r0, 0x01
    ldrsb r0, [r4, r0] ; load currently highlighted option
    mov r2, 0x80
    lsl r2, r2, 0x01
    add r0, r0, r2
    mov r3, 0x0e
    cmp r1, r0
    bne @@NotHighlighted ; branch if not matching
    mov r3, 0x0f ; presumably the palette
    @@NotHighlighted:
    ldr r0, =0x104
    cmp r1, r0
    ble @@Param2UB
    b @@Fallthrough
    @@Param2UB:
    ldr r0, =0x101
    cmp r1, r0
    bge @IsTextJump
        @@Fallthrough:
        ; r1 is less than 0x101 here
        ; skip other checks (<1, <5)
        cmp r1, r2
        beq @@DrawBox
        b @FuncEnd
    .pool
    .align
    @@DrawBox:
        bl 0x080923DC ; something with free rotation param indices
        add r5, r0, 0x00
        cmp r5, 0x00 ; r5 contains a rotation param index
        bge @DrawBoxMain
        b @FixCoords
    @IsTextJump:
        b @IsText
    @DrawBoxMain:
        mov r0, 0x00
        str r0, [sp]
        mov r0, r5
        mov r1, 0x00
        mov r2, 0x00
        mov r3, 0x00
        bl 0x080923FC ; idk, it's all boilerplate to me
        ; want the size 4 case for drawing the box - that's at 0x08014960
        mov r0, 0x02
        bl 0x080922D4 ; this function returns an address to insert data that will be loaded into OAM
            ; see http://problemkaputt.de/gbatek.htm#lcdobjoamattributes
        mov r3, r0
        cmp r3, 0x00
        beq @@NullObj1
        lsl r2, r5, 0x19
        mov r1, 0x04
        ldsh r0, [r4, r1]
        sub r0, 0x04
        lsl r0, r0, 0x10
        ldr r1, =0x1FF0000
        and r0, r1 ; gets x-coordinate (bits 16-24)
        ldr r1, =0x40004500 ; 0x4500 - rot/scaling on (bit8), semi-transparent (bit10), horizontal (bit14)
            ; bit31 - 32x8 if horizontal
        orr r0, r1
        orr r2, r0
        str r2, [r3] ;  attr 0 AND attr 1
        ldr r2, =0xF3FE
        mov r0, r2
        strh r0, [r3, 0x04] ; OAM attr 2 - pallete/priority/tile number
        ldrb r0, [r4, 0x06]
        add r0, 0x1c
        strb r0, [r3] ; 1st byte of attr 0 - y-coord
        
        @@NullObj1:
        mov r0, 0x02
        bl 0x080922D4
        mov r2, r0
        cmp r2, 0x00
        beq @@NullObj2
        mov r1, 0x04
        ldsh r0, [r4, r1]
        add r0, 0x1C
        lsl r0, r0, 0x10
        ldr r1, =0x1FF0000
        and r0, r1 ; x-coord
        mov r1, 0x80
        lsl r1, r1, 0x03 ; r1 = 0x400 - just semi-transparent
        orr r0, r1
        str r0, [r2]
        mov r1, 0xF0
        lsl r1, r1, 0x08 ; 0xF000 - obj palette 0xF
        mov r0, r1
        strh r0, [r2, 0x04]
        ldrb r0, [r4, 0x06]
        add r0, 0x1c
        strb r0, [r2]
        
        @@NullObj2:
        mov r0, 0x02
        bl 0x080922D4 ; bookkeeping - we're at 0x080149be
        add r3, r0, 0x00
        cmp r3, 0x00
        beq @@NullObj3
        lsl r2, r5, 0x19
        mov r1, 0x04
        ldsh r0, [r4, r1]
        sub r0, 0x04
        lsl r0, r0, 0x10
        ldr r1, =0x1FF0000
        and r0, r1
        ldr r1, =0x40004500
        orr r0, r1
        orr r2, r0
        str r2, [r3]
        ldr r2, =0xF3FE
        mov r0, r2
        strh r0, [r3, 0x04]
        ldrb r0, [r4, 0x06]
        add r0, 0x14 ; same as the part after beq @@NullObj3, except 0x1c replaced with 0x14
        strb r0, [r3]
        
        @@NullObj3:
        mov r0, 0x02
        bl 0x080922D4
        mov r2, r0
        cmp r2, 0x00
        beq @@NullObj4
        mov r1, 0x04
        ldsh r0, [r4, r1]
        add r0, 0x1C
        lsl r0, r0, 0x10
        ldr r1, =0x1FF0000
        and r0, r1
        mov r1, 0x80
        lsl r1, r1, 0x03
        orr r0, r1
        str r0, [r2]
        mov r1, 0xF0
        lsl r1, r1, 0x08
        mov r0, r1
        strh r0, [r2, 0x04]
        ldrb r0, [r4, 0x06]
        add r0, 0x14
        strb r0, [r2]
        
        @@NullObj4:
        mov r0, 0x02
        bl 0x080922D4 ; 0x08014a1a
        add r3, r0, 0x00
        cmp r3, 0x00
        beq @@NullObj5
        lsl r2, r5, 0x19
        mov r1, 0x04
        ldsh r0, [r4, r1]
        sub r0, 0x04
        lsl r0, r0, 0x10
        ldr r1, =0x1FF0000
        and r0, r1
        ldr r1, =0x40004500
        orr r0, r1
        orr r2, r0
        str r2, [r3]
        ldr r2, =0xF3FE
        mov r0, r2
        strh r0, [r3, 0x04]
        ldrb r0, [r4, 0x06]
        add r0, 0xC ; same as the part after beq @@NullObj1, except 0x1c replaced with 0x0c
        strb r0, [r3]
        
        @@NullObj5:
        mov r0, 0x02
        bl 0x080922D4
        mov r2, r0
        cmp r2, 0x00
        beq @@NullObj6
        mov r1, 0x04
        ldsh r0, [r4, r1]
        add r0, 0x1C
        lsl r0, r0, 0x10
        ldr r1, =0x1FF0000
        and r0, r1
        mov r1, 0x80
        lsl r1, r1, 0x03
        orr r0, r1
        str r0, [r2]
        mov r1, 0xF0
        lsl r1, r1, 0x08
        mov r0, r1
        strh r0, [r2, 0x04]
        ldrb r0, [r4, 0x06]
        add r0, 0x0C
        strb r0, [r2]
        
        @@NullObj6:
        mov r0, 0x02
        bl 0x080922D4 ; 08014a76
        add r3, r0, 0x00
        cmp r3, 0x00
        beq @@NullObj7
        lsl r2, r5, 0x19
        mov r1, 0x04
        ldsh r0, [r4, r1]
        sub r0, 0x04
        lsl r0, r0, 0x10
        ldr r1, =0x1FF0000
        and r0, r1
        ldr r1, =0x80004500
        orr r0, r1
        orr r2, r0
        str r2, [r3]
        ldr r2, =0xF3FA
        mov r0, r2
        strh r0, [r3, 0x04]
        ldrb r0, [r4, 0x06]
        sub r0, 0x04 ; same as the part after beq @@NullObj1, except 0x1c replaced with 0x04
        strb r0, [r3, 0x00]
        
        @@NullObj7:
        mov r0, 0x02
        bl 0x080922D4 ;08014aa4
        mov r2, r0
        cmp r2, 0x00
        beq @FixCoords
        mov r3, r2
        lsl r2, r5, 0x19
        mov r1, 0x04
        ldrsh r0, [r4, r1] ; x-coord
        add r0, 0x1c
        lsl r0, r0, 0x10
        ldr r1, =0x1FF0000
        and r0, r1
        mov r1, 0x85
        lsl r1, r1, 0x08
        orr r0, r1
        orr r2, r0
        str r2, [r3, 0x00]
        ldr r2, =0xF3FF
        add r0, r2, 0x00
        strh r0, [r3, 0x04]
        ldrb r0, [r4, 0x06] ; y-coord
        sub r0, 0x04
        strb r0, [r3, 0x00]
        
    @FixCoords:
        mov r0, 0x00
        ldrsb r0, [r4, r0]
        lsr r1, r0, 0x1f
        add r0, r0, r1
        asr r0, r0, 0x01 ; dividing by 2
        ldrh r1, [r4, 0x06]
        sub r1, r1, r0
        strh r1, [r4, 0x06]
        b @FuncEnd
        
    @IsText: ; 0x101 to 0x104 here (r1)
    sub r1, r1, r0 ; r1 now contains array index
    ldr r0, =PracticeCutsceneMenuOptions
    lsl r1, r1, 3
    add r2, r1, r0 ; string pointer
    mov r5, r2
    mov r1, 0x04
    ldrsh r0, [r4, r1] ; load x-coord
    mov r2, 0x06
    ldrsh r1, [r4, r2] ; load y-coord
    mov r2, r5 ; load string pointer, palette is already loaded
    bl 0x08094144 ; parse ASCII
    ldrh r0, [r4, 0x06]
    add r0, 0x09 ; line spacing
    strh r0, [r4, 0x06]
    
    @FuncEnd:
    mov r0, 0x00
    add sp, 0x04
    pop {r4, r5}
    pop r1
    bx r1
    .pool
    .align
PracticeCutsceneMenuOptions:
    @Start: .asciiz "Start" :: .align
    @Lose:  .asciiz "Lose"  :: .align
    @Retry: .asciiz "Retry" :: .align
    @Win:   .asciiz "Win"   :: .align

MagicLearnBG1PrepHook: ; BG1 is normally disabled in the Magic Learn screen. Let's enable it.
    push r14
    sub sp, 0x08
    
    mov r4, 0x02
    str r4, [sp, 0x00] ; tiles (06008000)
    mov r0, 0x01 ; layer
    mov r1, 0x10 ; number of colors?
    mov r2, 0x00 ; screen size
    str r2, [sp, 0x04] ; priority
    mov r3, 0x1d ; map offset
    bl 0x08000614 ; subroutine related to prepping a BG layer for use
    
    ldr r0, =0x081D6570
    ldr r1, =0x05000060
    mov r2, 0x20
    bl 0x08092030 ; DMA palette for the text
    
    ldr r0, =0x0819C204
    ldr r1, =0x05000360
    mov r2, 0x20
    bl 0x08092030 ; DMA the peltte for L/R arrows
    
    mov r4, 0x00
    add sp, 0x08
    pop r14
    bx r14
    
    .pool
    .align
    
MagicLearnBG0Hook: 
    push {r4, r5, r6, r14} ; need to preserve r4 for future tile map DMAs
    ; also just pushing r5 and r6 to be safe
    ; the magic information is now offset by 0x10 in the stack
    
    ; goal - DMA the new BG0 tileset and tilemap showing the magic trick name in bold yellow text
    ldr r0, =MagicHeaderTable
    add r6, sp, 0x168
    ldrh r1, [r6, 0x00] ; magic option
    lsl r1, r1, 0x03 ; each table entry, 2 dwords (8 bytes)
    add r1, r0
    mov r5, r1
    ldmia r5!, {r1} ; load tileset, increment r5 to get to tile map
    mov r0, 0x00
    bl 0x080008c8 ; special subroutine to decompress tileset and automatically DMA it to the right layer
    
    ldr r1, [r5]
    mov r0, 0x00
    bl 0x08000918 ; same ordeal, but for tilemap
    
    pop {r4, r5, r6}
    pop r14
    bx r14
    
.pool
.align
    
MagicLearnInitHook:
    push r14
    
    ; r9 = sp+0x34 (080229C0)
    ; line pointers typically stored starting at sp+0x44 (int array)
    ; illustrations are stored at sp+0x144, in two-byte structs (00 - illustration number, 01 - line number)
    ; number of illustrations is stored at sp+0x18C
    ; max number of lines is stored at sp+0x188, as an int
    ; current magic is stored at sp+0x158, as a short
    ; line position is stored at sp+0x15A, as a short
    ; [sp+0x184] has y-position more precisely, allowing for the scroll effect
    
    ; mind the offset+0x04 due to pushing r14
    
    ; PLAN: Put compressed tilesets/maps in free space, to be accessed using array lookups
    ; Store buffer pointers to uncompressed data at sp+0x48 (uncompress and DMA tile tilesets/maps sequentially)
    
    ; (this can be done separately) hard-code where illustrations should be, and use the same stack locations to store illustration + line numbers (only this time, page numbers)
    
    ldr r1, =TableMagicInstructions
    add r6, sp, 0x15C ; magic option
    ldrh r0, [r6, 0x00]
    lsl r0, r0, 0x02
    add r0, r1
    ldr r0, [r0, 0x00] ; magic option-specific instruction set
    mov r1, 0x00
    mov r8, r1 ; Loop variable
    
    @@Loop:
    mov r4, r0
    mov r9, r0
    ldr r0, [r4, 0x00] ; tileset pointer for one step, tilemap pointer would be at r4+0x04
    cmp r0, 0x00
    beq @@LoopEnd
    ; 3 things to accomplish - make the buffer, store the buffer on the stack, decompress the tileset and store at the buffer
    mov r5, r0
    ldmia r5!, {r1} ; tileset length is stored at the tileset pointer, also increment r5!
    mov r6, r1
    ldr r0, =0x030005D0
    bl 0x08091DAC ; magic subroutine that spits out a pointer in WRAM (a buffer), note the r1 argument being length
    add r7, r0, 0x00 ; buffer pointer
    add r0, r5, 0x00 ; tileset pointer (now points to the compressed tileset data)
    add r1, r7, 0x00 ; buffer pointer (to store data to)
    add r2, r6, 0x00 ; uncompressed length
    bl 0x08092134 ; decompress subroutine
    mov r1, r8
    lsl r1, r1, 0x02
    add r2, sp, 0x48
    add r1, r2
    mov r0, r7
    str r0, [r1, 0x00] ; store buffer pointer on stack
    
    ; Must also store uncompressed tileset length on stack!
    ; Let's do it at [sp+0x108], this cuts down useable buffers for tilesets/maps from 64 to 48
    add r0, r6, 0x00
    mov r1, r8 ; loop variable is incremented twice per loop, so this properly stores shorts
    add r2, sp, 0x108
    add r1, r2
    strh r0, [r1, 0x00]
    
    mov r1, r8
    add r1, r1, 0x01
    mov r8, r1 ; increment loop variable
    
    ; same process for the tile map
    mov r0, r9
    ldr r0, [r0, 0x04] ; tilemap pointer
    mov r5, r0
    ldmia r5!, {r1} ; tilemap length to r1, increment r5
    mov r6, r1
    ldr r0, =0x030005D0
    bl 0x08091DAC ; make buffer
    add r7, r0, 0x00
    add r0, r5, 0x00
    add r1, r7, 0x00
    add r2, r6, 0x00
    bl 0x08092134
    mov r1, r8
    lsl r1, r1, 0x02
    add r2, sp, 0x48
    add r1, r2
    mov r0, r7
    str r0, [r1, 0x00] ; store buffer pointer on stack. note the incremented loop variable
    
    mov r1, r8
    add r1, r1, 0x01
    mov r8, r1
    
    mov r0, 0x08
    add r0, r9 ; next screen!
    b @@Loop
    
    @@LoopEnd:
    mov r0, r8
    asr r0, r0, 0x01
    sub r0, 0x01
    add r1, sp, 0x18C
    str r0, [r1, 0x00] ; store number of pages
    
    mov r0, 0x01
    add r1, sp, 0x15C
    add r1, r1, 0x02
    strb r0, [r1, 0x00] ; old line position
    mov r0, 0x00
    strb r0, [r1, 0x01] ; new position
    
    ; Processing illustrations...
    ldr r1, =TableMagicImages
    add r6, sp, 0x15C ; magic option
    ldrh r0, [r6, 0x00]
    lsl r0, r0, 0x02
    add r0, r1
    ldr r0, [r0, 0x00] ; magic option-specific image set
    mov r1, 0x00
    mov r8, r1 ; loop var
    
    @@Loop2:
    mov r4, r0
    ldrh r0, [r4, 0x00] ; page number + ID of illustration, if it exists
    ldr r1, =0xFFFF ; terminate
    cmp r0, r1
    beq @@Loop2End
    
    add r1, sp, 0x148
    mov r2, r8
    lsl r2, r2, 0x01
    add r1, r2
    strh r0, [r1, 0x00] ; store page + ID together
    
    mov r1, r8
    add r1, r1, 0x01
    mov r8, r1 ; increment loop var
    
    add r0, r4, 0x02
    mov r4, r0
    b @@Loop2
    
    @@Loop2End:
    ; store number of illustrations
    add r1, sp, 0x190
    mov r0, r8
    str r0, [r1, 0x00]
    
    pop r14
    bx r14
    
.pool
.align

MagicLearnCursorHook:
    ; r0 = address to modify (pointer on stack) ** read a byte, not a short
    ; r1 = maximum value
    ; r2 = key inputs (L = 0x200, R = 0x100)
    ; r3 = sound effect
    ; basically copy 08094884
    
    push {r4, r5, lr}
    add r5, r0, 0x00
    ldrb r4, [r5, 0x00] ; r4 contains current position
    mov r0, 0x01
    lsl r0, r0, 0x09
    and r0, r2
    cmp r0, 0x00
    beq @@LNotPressed
    cmp r4, 0x00
    ble @@DoNothing ; L pressed at edge
    sub r0, r4, 0x01
    b @@StoreNewPosition
    @@LNotPressed: ; now check for R
    mov r0, 0x01
    lsl r0, r0, 0x08
    and r0, r2
    cmp r0, 0x00
    beq @@DoNothing
    ; R Pressed
    cmp r4, r1
    bge @@DoNothing ; R pressed at edge
    add r0, r4, 0x01
    @@StoreNewPosition:
    strb r0, [r5, 0x01] ; new position is at [current position + 1]
    @@DoNothing:
    ldrb r0, [r5, 0x01]
    cmp r4, r0 ; old versus new position
    beq @@NoSound
    add r0, r3, 0x00
    bl 0x0803CF44 ; sound effect
    @@NoSound:
    
    ; don't need a return value, just exit subroutine here
    pop {r4, r5}
    pop {r1}
    bx r1

.align
    
MagicLearnDisplayHook:
    push r14
    ; uhhh, use similar logic to drawing overworld to efficiently DMA the tileset/maps in the right place
    ; have a listener for L/R buttons, playing the appropriate sound effects
    
    ; (display L/R button controls as appropriate)
    
    ; see function that draws the overworld - ONLY writes to VRAM if the current step is not equal to the displayed one
    
    ; idea - put current position at sp+0x15E and th enew position at sp+0x15F, if not equal redraw background 0
    ; also use built-in function to DMA the tilemap (08093B5C)
    
    add r6, sp, 0x15C
    ldrb r0, [r6, 0x02]
    ldrb r1, [r6, 0x03]
    cmp r0, r1
    beq @@SkipNewRender
    
    ; put DMA-ing code in here
    strb r1, [r6, 0x02] ; overwrite current position
    
    lsl r0, r1, 0x03 ; tileset pointer every 8 bytes
    add r5, sp, 0x48
    add r0, r5
    mov r7, r0
    ldr r0, [r0]
    lsl r1, r1, 0x01 ; 
    mov r2, r5
    add r2, 0xC0 ; C0 + 48 = 108
    add r1, r2
    ldrh r2, [r1, 0x00] ; tileset length, as inserted from earlier (during init)
    ldr r1, =0x03003874 ; BG1 tileset pointer in VRAM, just hard-code it since we're not making a new subroutine
    ldr r1, [r1, 0x00]
    bl 0x08092030 ; prep the DMA
    
    sub sp, 0x04 ; be careful lol
    mov r2, 0x14
    str r2, [sp] ; # of vertical tiles
    mov r0, r7
    ldr r2, [r0, 0x04] ; tilemap pointer on stack
    ldr r0, =0x03003814 ; want 3800 + layer*0x14
    ldr r1, =0x0300386C ; 3850 + layer*0x1c
    mov r3, 0x1e ; # of horizontal tiles
    bl 0x08093B5C ; special DMA for tilemaps that account for the bounding box, ONLY if it is already uncompressed
    add sp, 0x04 ; all is good
    
    @@SkipNewRender:
    
    ; image rendering
    add r1, sp, 0x190
    ldr r0, [r1, 0x00] ; number of illustrations
    mov r8, r0 ; max number of loops
    mov r0, 0x00
    @@ImageLoop:
    mov r9, r0 ; number of loops
    cmp r0, r8
    bge @@FuncEnd
    
    add r1, sp, 0x148
    lsl r0, r0, 0x01
    add r3, r0, r1
    ldrb r0, [r3, 0x00] ; page number of illustration
    add r2, sp, 0x15c
    ldrb r2, [r2, 0x02] ; current page number
    cmp r0, r2
    bne @@IncrementLoop
    ; matching page numbers - draw illustration
    
    sub sp, 0x08 ; again, we're not BLing anywhere...
    ldr r2, =0x0803C1FC ; table of magic images (surprisingly, not compressed, meaning we can replace the data in-place)
    ldrb r0, [r3, 0x01] ; illustration number
    lsl r0, r0, 0x02
    add r0, r2
    ldr r0, [r0, 0x00] ; param: ROM pointer of object graphical data
    ldr r1, =0x030038C4
    ldrb r1, [r1, 0x00] ; param
    lsr r3, r1, 0x02
    lsl r3, r3, 0x0a ; param
    mov r2, 0x89
    str r2, [sp, 0x00] ; param - x-position
    mov r2, 0x3b
    str r2, [sp, 0x04] ; param - y-position
    mov r2, 0x00
    bl 0x08092C1C ; magic subroutine that writes an object to OAM consisting of multiple smaller objects
    add sp, 0x08
    
    @@IncrementLoop:
    mov r0, r9
    add r0, 0x01
    b @@ImageLoop
    
    .pool
    
    @@FuncEnd: ; done the previous loop
    
    ; now - draw L arrow if not at start, R arrow if not at end
    add r6, sp, 0x15C
    ldrb r0, [r6, 0x02]
    mov r9, r0
    cmp r0, 0x00
    beq @@NoLArrow ; at first page? Don't draw L arrow
    
    ; rendering code in here
    sub sp, 0x08
    ldr r0, =ObjLArrow ; param - pointer to object data for L arrow graphic
    mov r1, 0x00
    lsr r3, r1, 0x02
    lsl r3, r3, 0x0a ; param - 
    mov r2, 0x10
    str r2, [sp, 0x00] ; param - x-position
    mov r2, 0x04
    str r2, [sp, 0x04] ; param - y-position
    mov r2, 0x00
    bl 0x08092C1C ; draw the object
    add sp, 0x08
    
    @@NoLArrow:
    mov r0, r9
    add r6, sp, 0x18C
    ldrb r1, [r6, 0x00]
    cmp r0, r1
    bge @@NoRArrow ; at last page? Don't draw R arrow
    
    sub sp, 0x08
    ldr r0, =objRArrow
    mov r1, 0x00
    lsl r3, r1, 0x02
    lsl r3, r3, 0x0a
    mov r2, 0xC0
    str r2, [sp, 0x00]
    mov r2, 0x04
    str r2, [sp, 0x04]
    mov r2, 0x00
    bl 0x08092C1C
    add sp, 0x08
    
    @@NoRArrow:
    
    pop {r1}
    bx r1
    
.pool
.align
    
    PostResultsHook:
.ifndef __DEBUG__
    b @ResetRankHookEnd
.else
    .notice "[DEBUG]: Hold L during fadeout after results screen to reset your rank + seen location splashes"
.endif
    ldr r0, =0x030005E9
    ldrb r0, [r0, 0x00]
    mov r5, 0x02
    and r0, r5
    cmp r0, 0x00
    bne @LButtonHeld
    @ResetRankHookEnd:
    ldr r0, =0x030005A0
    add r0, 0x90
    bx r14
    .pool
    @LButtonHeld:
    ldr r0, =0x030005A0
    add r0, 0x90
    ldr r0, [r0, 0x00] ;get pointer to current SRAM file
    mov r5, 0x00
    strb r5, [r0, 0x09] ;overwrite rank
    strb r5, [r0, 0x0B] ;overwrite seen location splashes
    b @ResetRankHookEnd
    .pool
    .align
    
TitleScreenVersionStrHook:
; copy 10C92...
    push r14
    ldr r0, =0x030005A0
    ldr r0, [r0, 0x04]
    mov r1, 0x30
    and r0, r1
    cmp r0, 0x00
    beq @SkipPrint
    ldr r2, =0x08025038 ; str
    mov r0, 0x4C ; x
    mov r1, 0x78 ; y
    mov r3, 0x0F ; palette
    bl 0x080940C0
    @SkipPrint:
    ; new stuff!
    ldr r2, =@s_ENG
    mov r0, 0xD8
    mov r1, 0x88
    mov r3, 0x00
    bl 0x080940C0
    ldr r2, =@s_patchversion
    mov r0, 0xD0
    mov r1, 0x94
    mov r3, 0x00
    bl 0x080940C0
    
    pop r14
    bx r14
.pool
.align

@s_ENG:
    .asciiz "ENG"   ::  .align
@s_patchversion:
    .asciiz VERSION ::  .align

.endarea