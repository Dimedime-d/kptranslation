; this file is NOT automatically generated - you can nudge the x and y offsets so they look even...

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
	@W02:
		worldtitleheader    0,0
		inctitle	"world_kururinvillage"
	@W03:
		worldtitleheader    0,-1
		inctitle	"world_flowerland"
	@W04:
		worldtitleheader    0,-1
		inctitle	"world_clockland"
	@W05:
		worldtitleheader    0,0
		inctitle	"world_magickingdom"
	@W06:
		worldtitleheader    0,-1
		inctitle	"world_neoland"
	@L01: 
		owleveltitleheader	-2,0
		inctitle "training1"
	@L02:
		owleveltitleheader	0,0
		inctitle	"training2"
	@L03:
		owleveltitleheader	0,0
		inctitle	"training3"
	@L04:
		owleveltitleheader	0,0
		inctitle	"training4"
	@L05:
		owleveltitleheader	0,0
		inctitle	"training5"
	@L06:
		owleveltitleheader	0,-1
		inctitle	"village1"
	@L07:
		owleveltitleheader	0,-1
		inctitle	"village2"
	@L08:
		owleveltitleheader	0,-1
		inctitle	"village3"
	@L09:
		owleveltitleheader	0,0
		inctitle	"village4"
	@L0A:
		owleveltitleheader	0,-2
		inctitle	"village5"
	@L0B:
		owleveltitleheader	0,0
		inctitle	"village5a"
	@L0C:
		owleveltitleheader	0,0
		inctitle	"village4a"
	@L0D:
		owleveltitleheader	0,-1
		inctitle	"village4b"
	@L0E:
		owleveltitleheader	0,-1
		inctitle	"flower1"
	@L0F:
		owleveltitleheader	0,-1
		inctitle	"flower2"
	@L10:
		owleveltitleheader	0,-1
		inctitle	"flower3"
	@L11:
		owleveltitleheader	0,-2
		inctitle	"flower4"
	@L12:
		owleveltitleheaderbig	0,-1
		inctitle	"flower5"
	@L13:
		owleveltitleheader	0,-1
		inctitle	"flower5a"
	@L14:
		owleveltitleheaderbig	0,-1
		inctitle	"flower3a"
	@L15:
		owleveltitleheader	0,-1
		inctitle	"flower3b"
	@L16:
		owleveltitleheader	0,-1
		inctitle	"clock1"
	@L17:
		owleveltitleheaderbig	0,1
		inctitle	"clock2"
	@L18:
		owleveltitleheader	0,-2
		inctitle	"clock3"
	@L19:
		owleveltitleheaderbig   0,0
		inctitle	"clock4"
	@L1A:
		owleveltitleheaderbig	0,0
		inctitle	"clock5"
	@L1B:
		owleveltitleheaderbig	0,0
		inctitle	"clock4a"
	@L1C:
		owleveltitleheaderbig	0,-1
		inctitle	"clock3a"
	@L1D:
		owleveltitleheader	0,-1
		inctitle	"clock3b"
	@L1E:
		owleveltitleheader	0,0
		inctitle	"magic1"
	@L1F:
		owleveltitleheader	0,0
		inctitle	"magic2"
	@L20:
		owleveltitleheader	0,0
		inctitle	"magic3"
	@L21:
		owleveltitleheader	0,0
		inctitle	"magic4"
	@L22:
		owleveltitleheader	0,1
		inctitle	"magic5"
	@L23:
		owleveltitleheaderbig	0,0
		inctitle	"magic6"
	@L24:
		owleveltitleheaderbig	0,0
		inctitle	"magic4a"
	@L25:
		owleveltitleheaderbig	0,1
		inctitle	"magic4aa"
	@L26:
		owleveltitleheader	0,1
		inctitle	"magic4ab"
	@L27:
		owleveltitleheaderbig	0,0
		inctitle	"neo1"
	@L28:
		owleveltitleheader	0,-1
		inctitle	"neo2"
	@L29:
		owleveltitleheader	0,0
		inctitle	"neo3"
	@L2A:
		owleveltitleheader	0,-1
		inctitle	"neo4"
    @M01:
        owleveltitleheader  0,-1
        inctitle    "minigamesky"    
    @M02:
        owleveltitleheader  0,-1
        inctitle    "minigameshoot"  
    @M03:
        owleveltitleheader  0,-1
        inctitle    "minigametwin"  
    @M04:
        owleveltitleheader  0,-1
        inctitle    "minigamebounce"
    @M05:
        owleveltitleheader  0,-1
        inctitle    "minigamefall"
    @M06:
        owleveltitleheader  0,-1
        inctitle    "minigamegrass"
    @M07:
        owleveltitleheaderbig  0,0
        inctitle    "minigamestars"
    @M08:
        owleveltitleheader  0,-1
        inctitle    "minigamerace"
    @M09:
        owleveltitleheader  0,-1
        inctitle    "minigamedots"
    @M0A:
        owleveltitleheader  0,-1
        inctitle    "minigamecrossfire"
    @M0B:
        owleveltitleheader  0,-1
        inctitle    "minigamemagnet"
    @M0C:
        owleveltitleheader  0,0
        inctitle    "minigameice"
        
	;then, minigames: In the Sky, Spin Shot, Twin Hopper,
	;Super Jumper, Falling Down, Grass Cutter
	;Starlight Romance, Pit-pat racer, occupy
	;Crossfire, Magnemagne, Slip Drop,
.endautoregion

