; This file was automatically generated by formatsplashes.py

.macro pad
    .word 0x00 :: .align
.endmacro

; minigame splash struct array at 0x2E6D4 (16 bytes each)
; 1st dword (4 bytes) - palette pointer
; 2nd dword - tileset pointer (compressed)
; 3rd dword - compressed tileset size
; 4th dword - tilemap pointer (compressed)

; 0x02E6D4 ~ 0x02E6F4 - 2 blank entries

; 0x02E6F4 - crossfire palette would be here

.org 0x0802E6F8
    .word @crossfireTiles
    .word 0xEF8
    .word @crossfireMap

.org 0x0802E708
    .word @starTiles
    .word 0x14D9
    .word @starMap

.org 0x0802E718
    .word @bounceTiles
    .word 0x11E5
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
    .word 0x12C4
    .word @iceMap

.org 0x0802E768
    .word @skyTiles
    .word 0x106F
    .word @skyMap

.org 0x0802E798
    .word @fallTiles
    .word 0x1AF2
    .word @fallMap

.org 0x0802E7A8
    .word @magnetTiles
    .word 0x147D
    .word @magnetMap

.org 0x0802E7B8
    .word @raceTiles
    .word 0x1255
    .word @raceMap

.org 0x0802E7C8
    .word @shootTiles
    .word 0x14CE
    .word @shootMap

.org 0x0802E7D8
    .word @twinTiles
    .word 0x1651
    .word @twinMap

.autoregion
    .align
    @crossfireTiles:
    .incbin "graphics\minigamesplashes\dumps\crossfireTiles.dmp" :: pad
    @crossfireMap:
    .incbin "graphics\minigamesplashes\dumps\crossfireMap.dmp" :: pad

    @starTiles:
    .incbin "graphics\minigamesplashes\dumps\starTiles.dmp" :: pad
    @starMap:
    .incbin "graphics\minigamesplashes\dumps\starMap.dmp" :: pad

    @bounceTiles:
    .incbin "graphics\minigamesplashes\dumps\bounceTiles.dmp" :: pad
    @bounceMap:
    .incbin "graphics\minigamesplashes\dumps\bounceMap.dmp" :: pad

    @dotsTiles:
    .incbin "graphics\minigamesplashes\dumps\dotsTiles.dmp" :: pad
    @dotsMap:
    .incbin "graphics\minigamesplashes\dumps\dotsMap.dmp" :: pad

    @grassTiles:
    .incbin "graphics\minigamesplashes\dumps\grassTiles.dmp" :: pad
    @grassMap:
    .incbin "graphics\minigamesplashes\dumps\grassMap.dmp" :: pad

    @iceTiles:
    .incbin "graphics\minigamesplashes\dumps\iceTiles.dmp" :: pad
    @iceMap:
    .incbin "graphics\minigamesplashes\dumps\iceMap.dmp" :: pad

    @skyTiles:
    .incbin "graphics\minigamesplashes\dumps\skyTiles.dmp" :: pad
    @skyMap:
    .incbin "graphics\minigamesplashes\dumps\skyMap.dmp" :: pad

    @fallTiles:
    .incbin "graphics\minigamesplashes\dumps\fallTiles.dmp" :: pad
    @fallMap:
    .incbin "graphics\minigamesplashes\dumps\fallMap.dmp" :: pad

    @magnetTiles:
    .incbin "graphics\minigamesplashes\dumps\magnetTiles.dmp" :: pad
    @magnetMap:
    .incbin "graphics\minigamesplashes\dumps\magnetMap.dmp" :: pad

    @raceTiles:
    .incbin "graphics\minigamesplashes\dumps\raceTiles.dmp" :: pad
    @raceMap:
    .incbin "graphics\minigamesplashes\dumps\raceMap.dmp" :: pad

    @shootTiles:
    .incbin "graphics\minigamesplashes\dumps\shootTiles.dmp" :: pad
    @shootMap:
    .incbin "graphics\minigamesplashes\dumps\shootMap.dmp" :: pad

    @twinTiles:
    .incbin "graphics\minigamesplashes\dumps\twinTiles.dmp" :: pad
    @twinMap:
    .incbin "graphics\minigamesplashes\dumps\twinMap.dmp" :: pad
.endautoregion