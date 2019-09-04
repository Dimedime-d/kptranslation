.org 0x08008270
	beq NewLabel

.org 0x0800831A	;1st menu selection, attempt to mod
	bl 0x080922D4
	mov r2,r0
	cmp r2,0h
	beq 0x080083C8
	ldr r0,=0x40684000
	str r0,[r2]
	lsl r0,r5,0x0C
	mov r3,0x9B
	lsl r3,r3,0x01	;new code beyond here
	mov r1,r3
	orr r0,r1
	strh r0,[r2,4h]
	ldrh r0,[r4,6h]
	strb r0,[r2]
	mov r0,r1
	bl 0x080922D4
	mov r2,r0
	cmp r2,0x00
	beq 0x080083C8
	mov r0,0x84
	lsl r0,r0,0x10 ;hopefully the right object data?
	str r0,[r2]
	lsl r0,r5,0x0C
	mov r3,0x9D
	lsl r3,r3,0x01
	b 0x080083BE
	.pool

NewLabel:
	mov r0,0x01
	ldsb r0,[r4,r0]
	mov r5,0x0E
	cmp r0,0x02
	bne 0x08008340	;if current option is selected, highlight it
	mov r5,0x0F
	mov r0,0x01
	bl 0x080922D4
	mov r2,r0
	cmp r2,0h
	beq 0x080083C8
	ldr r0,=0x40684000
	str r0,[r2]
	lsl r0,r5,0x0C
	mov r3,0x9E
	lsl r3,r3,0x01
	b 0x080083BE
	.pool