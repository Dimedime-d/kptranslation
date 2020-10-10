;r0, r1, r2, r3 = x, y, str, palette

.org somewhere

push {r4, r5, r6, r7, lr}

mov r4, r0
mov r5, r1

mov r0, 0x10
rsb r0, r0
cmp r5, r0 ;y < -0x10
ble @y_oob
cmp r5, 0x9F ;y > 0x9F
bgt @y_oob

ldr r0, =0x030005D0
mov r1
lsl r1, r1, 0x07 ;0x4000 bytes should be enough
bl 0x08091DAC ; create buffer

;--------------
;	Da loop
;--------------













@y_oob:
pop {r4, r5, r6, r7}
pop r1
bx r1