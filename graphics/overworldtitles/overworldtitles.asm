; this file is NOT automatically generated - you can nudge the x and y offsets so they look even...

.org 0x082A0714 
.region 0x082AAE34-.,00 ; space taken by original level titles
.endregion

.macro worldtitleheader,xOffset,yOffset
	.byte   0x03,0x70,0x20+xOffset,0x08+yOffset, \
            0xD1,0xF9,0x24,0x08, \
            0xF1,0xF9,0x24,0x08, \
			0x11,0xF9,0x24,0x08
.endmacro

.macro owleveltitleheader,xOffset,yOffset
	.byte 	0x03,0x70,0x27+xOffset,0x08+yOffset, \
			0xD1,0xF9,0x24,0x08, \
			0xF1,0xF9,0x24,0x08, \
			0x11,0xF9,0x24,0x08
.endmacro

.macro owleveltitleheaderbig,xOffset,yOffset
	.byte	0x03,0x70,0x27+xOffset,0x08+yOffset, \
			0xD1,0xE9,0x44,0x10, \
			0xF1,0xE9,0x44,0x10, \
			0x11,0xE9,0x44,0x10
.endmacro

.macro inctitle,lvlName
	.incbin "graphics/overworldtitles/dumps/"+lvlName+".dmp"
.endmacro
					
.org 0x0802E3C4 ;repoint world title gfx
	.word @W01 ; world1
	.word @W02
	.word @W03
	.word @W04
	.word @W05
	.word @W06
	.word @L01 ; level1
	.word @L02
	.word @L03
	.word @L04
	.word @L05
	.word @L06
	.word @L07
	.word @L08
	.word @L09
	.word @L0A
	.word @L0B
	.word @L0C
	.word @L0D
	.word @L0E
	.word @L0F
	.word @L10
	.word @L11
	.word @L12
	.word @L13
	.word @L14
	.word @L15
	.word @L16
	.word @L17
	.word @L18
	.word @L19
	.word @L1A
	.word @L1B
	.word @L1C
	.word @L1D
	.word @L1E
	.word @L1F
	.word @L20
	.word @L21
	.word @L22
	.word @L23
	.word @L24
	.word @L25
	.word @L26
	.word @L27
	.word @L28
	.word @L29
	.word @L2A
    .word @M01
    .word @M02
    .word @M03
    .word @M04
    .word @M05
    .word @M06
    .word @M07
    .word @M08
    .word @M09
    .word @M0A
    .word @M0B
    .word @M0C

.autoregion
    .align
	@W01:
		worldtitleheader    0,0
		inctitle	"world_trainingroom"
.endautoregion
.autoregion :: .align
	@W02:
		worldtitleheader    0,0
		inctitle	"world_kururinvillage"
.endautoregion
.autoregion :: .align
	@W03:
		worldtitleheader    0,-1
		inctitle	"world_flowerland"
.endautoregion
.autoregion :: .align
	@W04:
		worldtitleheader    0,-1
		inctitle	"world_clockland"
.endautoregion
.autoregion :: .align
	@W05:
		worldtitleheader    0,0
		inctitle	"world_magickingdom"
.endautoregion
.autoregion :: .align
	@W06:
		worldtitleheader    0,-1
		inctitle	"world_neoland"
.endautoregion
.autoregion :: .align
	@L01: 
		owleveltitleheader	-2,0
		inctitle "training1"
.endautoregion
.autoregion :: .align
	@L02:
		owleveltitleheader	0,0
		inctitle	"training2"
.endautoregion
.autoregion :: .align
	@L03:
		owleveltitleheader	0,0
		inctitle	"training3"
.endautoregion
.autoregion :: .align
	@L04:
		owleveltitleheader	0,0
		inctitle	"training4"
.endautoregion
.autoregion :: .align
	@L05:
		owleveltitleheader	0,0
		inctitle	"training5"
.endautoregion
.autoregion :: .align
	@L06:
		owleveltitleheader	0,-1
		inctitle	"village1"
.endautoregion
.autoregion :: .align
	@L07:
		owleveltitleheader	0,-1
		inctitle	"village2"
.endautoregion
.autoregion :: .align
	@L08:
		owleveltitleheader	0,-1
		inctitle	"village3"
.endautoregion
.autoregion :: .align
	@L09:
		owleveltitleheader	0,0
		inctitle	"village4"
.endautoregion
.autoregion :: .align
	@L0A:
		owleveltitleheader	0,-2
		inctitle	"village5"
.endautoregion
.autoregion :: .align
	@L0B:
		owleveltitleheader	0,0
		inctitle	"village5a"
.endautoregion
.autoregion :: .align
	@L0C:
		owleveltitleheader	0,0
		inctitle	"village4a"
.endautoregion
.autoregion :: .align
	@L0D:
		owleveltitleheader	0,-1
		inctitle	"village4b"
.endautoregion
.autoregion :: .align
	@L0E:
		owleveltitleheader	0,-1
		inctitle	"flower1"
.endautoregion
.autoregion :: .align
	@L0F:
		owleveltitleheader	0,-1
		inctitle	"flower2"
.endautoregion
.autoregion :: .align
	@L10:
		owleveltitleheader	0,-1
		inctitle	"flower3"
.endautoregion
.autoregion :: .align
	@L11:
		owleveltitleheader	0,-2
		inctitle	"flower4"
.endautoregion
.autoregion :: .align
	@L12:
		owleveltitleheaderbig	0,-1
		inctitle	"flower5"
.endautoregion
.autoregion :: .align
	@L13:
		owleveltitleheader	0,-1
		inctitle	"flower5a"
.endautoregion
.autoregion :: .align
	@L14:
		owleveltitleheaderbig	0,-1
		inctitle	"flower3a"
.endautoregion
.autoregion :: .align
	@L15:
		owleveltitleheader	0,-1
		inctitle	"flower3b"
.endautoregion
.autoregion :: .align
	@L16:
		owleveltitleheader	0,-1
		inctitle	"clock1"
.endautoregion
.autoregion :: .align
	@L17:
		owleveltitleheaderbig	0,1
		inctitle	"clock2"
.endautoregion
.autoregion :: .align
	@L18:
		owleveltitleheader	0,-2
		inctitle	"clock3"
.endautoregion
.autoregion :: .align
	@L19:
		owleveltitleheaderbig   0,0
		inctitle	"clock4"
.endautoregion
.autoregion :: .align
	@L1A:
		owleveltitleheaderbig	0,0
		inctitle	"clock5"
.endautoregion
.autoregion :: .align
	@L1B:
		owleveltitleheaderbig	0,0
		inctitle	"clock4a"
.endautoregion
.autoregion :: .align
	@L1C:
		owleveltitleheaderbig	0,-1
		inctitle	"clock3a"
.endautoregion
.autoregion :: .align
	@L1D:
		owleveltitleheader	0,-1
		inctitle	"clock3b"
.endautoregion
.autoregion :: .align
	@L1E:
		owleveltitleheader	0,0
		inctitle	"magic1"
.endautoregion
.autoregion :: .align
	@L1F:
		owleveltitleheader	0,0
		inctitle	"magic2"
.endautoregion
.autoregion :: .align
	@L20:
		owleveltitleheader	0,0
		inctitle	"magic3"
.endautoregion
.autoregion :: .align
	@L21:
		owleveltitleheader	0,0
		inctitle	"magic4"
.endautoregion
.autoregion :: .align
	@L22:
		owleveltitleheader	0,1
		inctitle	"magic5"
.endautoregion
.autoregion :: .align
	@L23:
		owleveltitleheaderbig	0,0
		inctitle	"magic6"
.endautoregion
.autoregion :: .align
	@L24:
		owleveltitleheaderbig	0,0
		inctitle	"magic4a"
.endautoregion
.autoregion :: .align
	@L25:
		owleveltitleheaderbig	0,1
		inctitle	"magic4aa"
.endautoregion
.autoregion :: .align
	@L26:
		owleveltitleheader	0,1
		inctitle	"magic4ab"
.endautoregion
.autoregion :: .align
	@L27:
		owleveltitleheaderbig	0,0
		inctitle	"neo1"
.endautoregion
.autoregion :: .align
	@L28:
		owleveltitleheader	0,-1
		inctitle	"neo2"
.endautoregion
.autoregion :: .align
	@L29:
		owleveltitleheader	0,0
		inctitle	"neo3"
.endautoregion
.autoregion :: .align
	@L2A:
		owleveltitleheader	0,-1
		inctitle	"neo4"
.endautoregion
.autoregion :: .align
    @M01:
        owleveltitleheader  0,-1
        inctitle    "minigamesky" 
.endautoregion
.autoregion :: .align   
    @M02:
        owleveltitleheader  0,-1
        inctitle    "minigameshoot"  
.endautoregion
.autoregion :: .align
    @M03:
        owleveltitleheader  0,-1
        inctitle    "minigametwin"
.endautoregion
.autoregion :: .align  
    @M04:
        owleveltitleheader  0,-1
        inctitle    "minigamebounce"
.endautoregion
.autoregion :: .align
    @M05:
        owleveltitleheader  0,-1
        inctitle    "minigamefall"
.endautoregion
.autoregion :: .align
    @M06:
        owleveltitleheader  0,-1
        inctitle    "minigamegrass"
.endautoregion
.autoregion :: .align
    @M07:
        owleveltitleheaderbig  0,0
        inctitle    "minigamestars"
.endautoregion
.autoregion :: .align
    @M08:
        owleveltitleheader  0,-1
        inctitle    "minigamerace"
.endautoregion
.autoregion :: .align
    @M09:
        owleveltitleheader  0,-1
        inctitle    "minigamedots"
.endautoregion
.autoregion :: .align
    @M0A:
        owleveltitleheader  0,-1
        inctitle    "minigamecrossfire"
.endautoregion
.autoregion :: .align
    @M0B:
        owleveltitleheader  0,-1
        inctitle    "minigamemagnet"
.endautoregion
.autoregion :: .align
    @M0C:
        owleveltitleheader  0,0
        inctitle    "minigameice"
.endautoregion
	;then, minigames: In the Sky, Spin Shot, Twin Hopper,
	;Super Jumper, Falling Down, Grass Cutter
	;Starlight Romance, Pit-pat racer, occupy
	;Crossfire, Magnemagne, Slip Drop,



