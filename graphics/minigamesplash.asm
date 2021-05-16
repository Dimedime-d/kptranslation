; 0x0802E6F8 - Crossfire
; 0x0802E708 - Starlight Romance

.org 0x0802E718
    .word @bounceTiles
    .word 0x25DF
    .word @

; 0x0802E738 - Dot Filler
; 0x0802E748 - Grass Cutter
; 0x0802E758 - Slip Drop

.org 0x0802E768
	.word @skyTiles
	.word 0x205F ;uncompressed size - 1
	.word @skyMap

; 0x0802E798 - Falling Down
; 0x0802E7A8 - Magnet Force
; 0x0802E7B8 - Pit-Pat Racer
; 0x0802E7C8 - Spin Shot
; 0x0802E7D8 - Twin Hopper

.autoregion
    .align
	@skyTiles:
	.incbin "bin/minigame/InTheSkyTiles.bin"
    .word 0x00
	.align
	@skyMap:
	.incbin "bin/minigame/InTheSkyMap.bin"
    .word 0x00
    .align
    @bounceTiles:
    .incbin "bin/minigame/BounceTiles.bin"
    .word 0x00
    .align
    @bounceMap:
    .incbin "bin/minigame/BounceMap.bin"
    .word 0x00
    .align
.endautoregion