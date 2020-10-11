;r0, r1, r2, r3 = x, y, str, palette

.org text_weld_test ;dummy

push {r4, r5, r6, r7, r8, lr}

mov r4, r2 ;str
mov r5, r0 ;x
mov r6, r1 ;y
mov r7, r3 ;pal

sub sp, 0x04
mov r0, 0x00
str r0, [sp]

mov r0, 0x10
neg r0, r0
cmp r6, r0 ;y < -0x10
ble @y_oob
cmp r6, 0x9F ;y > 0x9F
bgt @y_oob

ldr r0, =0x030005D0
mov r1, 0x10
lsl r1, r1, 0x07 ;0x4000 bytes should be enough
bl 0x08091DAC ; create buffer
mov r8, r0 ;r8 contains buffer
b @branch_1
;--------------
;	Da loop
;--------------
@loop_start:
	lsr r1, r1, 0x18
	lsl r0, r0, 0x08
	orr r0, r1
	lsl r0, r0, 0x10
	lsr r0, r0, 0x10 ;reverse endianness of glyph

	ldr r1, =0x833F
	cmp r0, r1
	bls @check2
	b @branch_1
	.pool
	
@check2:
	ldr r1, =0x823F
	cmp r0, r1
	bls @branch_1
@english_char: ;just a case denoting such
	ldr r1, =0x0300585C ;relative offset table ptr for font
	ldr r1, [r1]
	lsl r0, r0, 2h
	add r0, r0, r1
	ldr r1, =0xFFFDFB00
	b @get_relative_offset
	.pool

@get_relative_offset:
	add r0, r0, r1
	ldr r2, [r0] ;to be continued...
	

@branch_1:
	ldrh r0, [r4, 0x00]
	lsl r1, r0, 0x10
	add r4, 0x02
	cmp r1, 0x00
	beq @null_terminator
	cmp r5, 0xEF
	ble @loop_start ;some break codes (or x > 0xEF)
	
;end of func
@null_terminator:
@y_oob:
;gotta clean up the buffer regardless...
ldr r0, =0x030005D0
mov r1, r7
bl 0x08091D58

add sp, 0x04
pop {r4, r5, r6, r7, r8}
pop r1
bx r1

.pool