.macro pad
    .word 0x00 :: .align
.endmacro

.org 0x0802E6F8
    .word @crossfireTiles
    .word 0xEF4
    .word @crossfireMap

.org 0x0802E708
    .word @starTiles
    .word 0x14D1
    .word @starMap

.org 0x0802E718
    .word @bounceTiles
    .word 0x11E4
    .word @bounceMap

.org 0x0802E738
    .word @dotsTiles
    .word 0x1435
    .word @dotsMap

.org 0x0802E748
    .word @grassTiles
    .word 0x1484
    .word @grassMap

.org 0x0802E758
    .word @iceTiles
    .word 0x12C3
    .word @iceMap

.org 0x0802E768
	.word @skyTiles
	.word 0x106E ; compressed size
	.word @skyMap

.org 0x0802E798
    .word @fallTiles
    .word 0x1AF1
    .word @fallMap

.org 0x0802E7A8 
    .word @magnetTiles
    .word 0x147A
    .word @magnetMap

.org 0x0802E7B8
    .word @raceTiles
    .word 0x1253
    .word @raceMap

.org 0x0802E7C8
    .word @shootTiles
    .word 0x14C7
    .word @shootMap

.org 0x0802E7D8
    .word @twinTiles
    .word 0x1651
    .word @twinMap

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
    @crossfireTiles:
    .incbin "bin/minigame/CrossfireTiles.bin" :: pad
    @crossfireMap:
    .incbin "bin/minigame/CrossfireMap.bin" :: pad
    @dotsTiles:
    .incbin "bin/minigame/DotsTiles.bin" :: pad
    @dotsMap:
    .incbin "bin/minigame/DotsMap.bin" :: pad
    @raceTiles:
    .incbin "bin/minigame/RaceTiles.bin" :: pad
    @raceMap:
    .incbin "bin/minigame/RaceMap.bin" :: pad
    @twinTiles:
    .incbin "bin/minigame/TwinTiles.bin" :: pad
    @twinMap:
    .incbin "bin/minigame/TwinMap.bin" :: pad
    @shootTiles:
    .incbin "bin/minigame/ShootTiles.bin" :: pad
    @shootMap:
    .incbin "bin/minigame/ShootMap.bin" :: pad
    @fallTiles:
    .incbin "bin/minigame/FallTiles.bin" :: pad
    @fallMap:
    .incbin "bin/minigame/FallMap.bin" :: pad
    @grassTiles:
    .incbin "bin/minigame/GrassTiles.bin" :: pad
    @grassMap:
    .incbin "bin/minigame/GrassMap.bin" :: pad
.endautoregion