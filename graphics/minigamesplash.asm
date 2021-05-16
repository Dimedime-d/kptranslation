.macro pad
    .word 0x00 :: .align
.endmacro

; 0x0802E6F8 - Crossfire
; 0x0802E708 - Starlight Romance

.org 0x0802E708
    .word @starTiles
    .word 0x14D1
    .word @starMap

.org 0x0802E718
    .word @bounceTiles
    .word 0x11E4
    .word @bounceMap

; 0x0802E738 - Dot Filler
; 0x0802E748 - Grass Cutter

.org 0x0802E758
    .word @iceTiles
    .word 0x12C3
    .word @iceMap

.org 0x0802E768
	.word @skyTiles
	.word 0x106E ; compressed size
	.word @skyMap

; 0x0802E798 - Falling Down

.org 0x0802E7A8 
    .word @magnetTiles
    .word 0x147A
    .word @magnetMap

; 0x0802E7B8 - Pit-Pat Racer
; 0x0802E7C8 - Spin Shot
; 0x0802E7D8 - Twin Hopper

.autoregion
    .align
	@skyTiles:
	.incbin "bin/minigame/InTheSkyTiles.bin" :: pad
	@skyMap:
	.incbin "bin/minigame/InTheSkyMap.bin" :: pad
    @bounceTiles:
    .incbin "bin/minigame/BounceTiles.bin" :: pad
    @bounceMap:
    .incbin "bin/minigame/BounceMap.bin" :: pad
    @starTiles:
    .incbin "bin/minigame/StarTiles.bin" :: pad
    @starMap:
    .incbin "bin/minigame/StarMap.bin" :: pad
    @iceTiles:
    .incbin "bin/minigame/IceTiles.bin" :: pad
    @iceMap:
    .incbin "bin/minigame/IceMap.bin" :: pad
    @magnetTiles:
    .incbin "bin/minigame/MagnetTiles.bin" :: pad
    @magnetMap:
    .incbin "bin/minigame/MagnetMap.bin" :: pad
.endautoregion