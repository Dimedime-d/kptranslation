;mimic 0x080A7044 EXCEPT where it adds constant width
.word 0x00000005
.word 0
.word Label1
.word 0x00000003	;<-0x080A7050

Label1:
.word 0x00090002
.word Label2
.word 0x00080001
.word 0				;<-0x080A7060

Label2:
.word 0x00000006
.word 0x7FFFFF03
.word 0x0
.word 0x00000006	;<-0x080A7070
.word 0x7FFFFF0A
.word 0x7FFFFF06
Label6:
.word 0x00000006
.word 0x7FFFFF04	;<-0x080A7080
.word 0
Label5:
.word 0x00090006
.word 0x7FFFFF0B
.word 0x7FFFFF03	;<-0x080A7090
.word 0x7FFFFF19
.word 0x00010006
.word 0x7FFFFF03
.word 0x00000001	;<-0x080A70A0
.word 0x00010002
.word Label3 ;0x080A7134
.word 0x7FFFFF0B
.word 0xFFFFFFFE	;<-0x080A70B0
.word 0x0000000A
.word 0x7FFFFF0A
.word 0x7FFFFF0B
.word 0				;<-0x080A70C0
.word 0x000F000A
.word 0x7FFFFF0A
.word 0
.word 0x0003E000	;<-0x080A70D0
.word 0x0009000A
.word 0x7FFFFF0A
.word 0x7FFFFF14
.word 0x7FFFFF15	;<-0x080A70E0
.word 0x00040002
.word Label4 ;0x080A7148
.word 0x7FFFFF03
.word 0x7FFFFF18	;<-0x080A70F0
.word 0x000F0006 ;the ONE byte i need to change, 01 to 0F
.word 0x7FFFFF14
.word 0x0000000D
.word 0x00010006	;<-0x080A7100
.word 0x7FFFFF0A
.word 0x00000001
.word 0x00010006
.word 0x7FFFFF04	;<-0x080A7110
.word 0x00000001
.word 0x00010006
.word 0x7FFFFF06
.word 0x00000001	;<-0x080A7120
.word 0x00050002
.word Label5 ;->0x080A7088
.word 0x7FFFFF04
.word 0x00000011	;<-0x080A7130
Label3:
.word 0x00010006
.word 0x7FFFFF15
.word 0x00000010
.word 0x00000002	;<-0x080A7140
.word Label6 ;-> 0x080A707C
.word 0x00010006
Label4:
.word 0x00000006
.word 0x00000001	;<-0x080A7150
.word 0x00000003

;.org 0x080A9ABC
;	.word to-be-repointed
;
;to-be-repointed:
;	.include vwfInstaText.asm
