; This file was automatically generated by formatsplashes.py

.org    0x082339F4
.region 0x08278D98-.,00 ; space taken by original minigame splash screens
.endregion

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

.org 0x0802E7F4
    .word @chuchuPalette
    .word @chuchuTiles
    .word @chuchuTilesEnd - @chuchuTiles
    .word @chuchu_challengeMap
    
.org 0x0802E904
    .word @chuchuPalette
    .word @chuchuTiles
    .word @chuchuTilesEnd - @chuchuTiles
    .word @chuchu_multiMap
    

.org 0x0802E6F4
    .word @crossfirePalette
    .word @crossfireTiles
    .word @crossfireTilesEnd - @crossfireTiles
    .word @crossfireMap
    
.org 0x0802E804
    .word @crossfirePalette
    .word @crossfireTiles
    .word @crossfireTilesEnd - @crossfireTiles
    .word @crossfire_challengeMap
    
.org 0x0802E914
    .word @crossfirePalette
    .word @crossfireTiles
    .word @crossfireTilesEnd - @crossfireTiles
    .word @crossfire_multiMap
    

.org 0x0802E704
    .word @starPalette
    .word @starTiles
    .word @starTilesEnd - @starTiles
    .word @starMap
    
.org 0x0802E814
    .word @starPalette
    .word @starTiles
    .word @starTilesEnd - @starTiles
    .word @star_challengeMap
    
.org 0x0802E924
    .word @starPalette
    .word @starTiles
    .word @starTilesEnd - @starTiles
    .word @star_multiMap
    

.org 0x0802E714
    .word @bouncePalette
    .word @bounceTiles
    .word @bounceTilesEnd - @bounceTiles
    .word @bounceMap
    
.org 0x0802E824
    .word @bouncePalette
    .word @bounceTiles
    .word @bounceTilesEnd - @bounceTiles
    .word @bounce_challengeMap
    
.org 0x0802E934
    .word @bouncePalette
    .word @bounceTiles
    .word @bounceTilesEnd - @bounceTiles
    .word @bounce_multiMap
    

.org 0x0802E834
    .word @hockeyPalette
    .word @hockeyTiles
    .word @hockeyTilesEnd - @hockeyTiles
    .word @hockey_challengeMap
    
.org 0x0802E944
    .word @hockeyPalette
    .word @hockeyTiles
    .word @hockeyTilesEnd - @hockeyTiles
    .word @hockey_multiMap
    

.org 0x0802E734
    .word @dotsPalette
    .word @dotsTiles
    .word @dotsTilesEnd - @dotsTiles
    .word @dotsMap
    
.org 0x0802E844
    .word @dotsPalette
    .word @dotsTiles
    .word @dotsTilesEnd - @dotsTiles
    .word @dots_challengeMap
    
.org 0x0802E954
    .word @dotsPalette
    .word @dotsTiles
    .word @dotsTilesEnd - @dotsTiles
    .word @dots_multiMap
    

.org 0x0802E744
    .word @grassPalette
    .word @grassTiles
    .word @grassTilesEnd - @grassTiles
    .word @grassMap
    
.org 0x0802E854
    .word @grassPalette
    .word @grassTiles
    .word @grassTilesEnd - @grassTiles
    .word @grass_challengeMap
    
.org 0x0802E964
    .word @grassPalette
    .word @grassTiles
    .word @grassTilesEnd - @grassTiles
    .word @grass_multiMap
    

.org 0x0802E754
    .word @icePalette
    .word @iceTiles
    .word @iceTilesEnd - @iceTiles
    .word @iceMap
    
.org 0x0802E864
    .word @icePalette
    .word @iceTiles
    .word @iceTilesEnd - @iceTiles
    .word @ice_challengeMap
    
.org 0x0802E974
    .word @icePalette
    .word @iceTiles
    .word @iceTilesEnd - @iceTiles
    .word @ice_multiMap
    

.org 0x0802E764
    .word @skyPalette
    .word @skyTiles
    .word @skyTilesEnd - @skyTiles
    .word @skyMap
    
.org 0x0802E874
    .word @skyPalette
    .word @skyTiles
    .word @skyTilesEnd - @skyTiles
    .word @sky_challengeMap
    
.org 0x0802E984
    .word @skyPalette
    .word @skyTiles
    .word @skyTilesEnd - @skyTiles
    .word @sky_multiMap
    

.org 0x0802E884
    .word @flipPalette
    .word @flipTiles
    .word @flipTilesEnd - @flipTiles
    .word @flip_challengeMap
    
.org 0x0802E994
    .word @flipPalette
    .word @flipTiles
    .word @flipTilesEnd - @flipTiles
    .word @flip_multiMap
    

.org 0x0802E894
    .word @lovePalette
    .word @loveTiles
    .word @loveTilesEnd - @loveTiles
    .word @love_challengeMap
    
.org 0x0802E9A4
    .word @lovePalette
    .word @loveTiles
    .word @loveTilesEnd - @loveTiles
    .word @love_multiMap
    

.org 0x0802E794
    .word @fallPalette
    .word @fallTiles
    .word @fallTilesEnd - @fallTiles
    .word @fallMap
    
.org 0x0802E8A4
    .word @fallPalette
    .word @fallTiles
    .word @fallTilesEnd - @fallTiles
    .word @fall_challengeMap
    
.org 0x0802E9B4
    .word @fallPalette
    .word @fallTiles
    .word @fallTilesEnd - @fallTiles
    .word @fall_multiMap
    

.org 0x0802E7A4
    .word @magnetPalette
    .word @magnetTiles
    .word @magnetTilesEnd - @magnetTiles
    .word @magnetMap
    
.org 0x0802E8B4
    .word @magnetPalette
    .word @magnetTiles
    .word @magnetTilesEnd - @magnetTiles
    .word @magnet_challengeMap
    
.org 0x0802E9C4
    .word @magnetPalette
    .word @magnetTiles
    .word @magnetTilesEnd - @magnetTiles
    .word @magnet_multiMap
    

.org 0x0802E7B4
    .word @racePalette
    .word @raceTiles
    .word @raceTilesEnd - @raceTiles
    .word @raceMap
    
.org 0x0802E8C4
    .word @racePalette
    .word @raceTiles
    .word @raceTilesEnd - @raceTiles
    .word @race_challengeMap
    
.org 0x0802E9D4
    .word @racePalette
    .word @raceTiles
    .word @raceTilesEnd - @raceTiles
    .word @race_multiMap
    

.org 0x0802E7C4
    .word @shootPalette
    .word @shootTiles
    .word @shootTilesEnd - @shootTiles
    .word @shootMap
    
.org 0x0802E8D4
    .word @shootPalette
    .word @shootTiles
    .word @shootTilesEnd - @shootTiles
    .word @shoot_challengeMap
    
.org 0x0802E9E4
    .word @shootPalette
    .word @shootTiles
    .word @shootTilesEnd - @shootTiles
    .word @shoot_multiMap
    

.org 0x0802E7D4
    .word @twinPalette
    .word @twinTiles
    .word @twinTilesEnd - @twinTiles
    .word @twinMap
    
.org 0x0802E8E4
    .word @twinPalette
    .word @twinTiles
    .word @twinTilesEnd - @twinTiles
    .word @twin_challengeMap
    
.org 0x0802E9F4
    .word @twinPalette
    .word @twinTiles
    .word @twinTilesEnd - @twinTiles
    .word @twin_multiMap
    

.autoregion :: .align   
    @chuchuTiles:
    .incbin "graphics\minigamesplashes\dumps\chuchuTiles.dmp" :: @chuchuTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @chuchu_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\chuchu_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @chuchu_multiMap:
    .incbin "graphics\minigamesplashes\dumps\chuchu_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @chuchuPalette:
    .incbin "kp.gba",0x246730,0x200
.endautoregion

.autoregion :: .align   
    @crossfireTiles:
    .incbin "graphics\minigamesplashes\dumps\crossfireTiles.dmp" :: @crossfireTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @crossfireMap:
    .incbin "graphics\minigamesplashes\dumps\crossfireMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @crossfire_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\crossfire_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @crossfire_multiMap:
    .incbin "graphics\minigamesplashes\dumps\crossfire_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @crossfirePalette:
    .incbin "kp.gba",0x247CE4,0x200
.endautoregion

.autoregion :: .align   
    @starTiles:
    .incbin "graphics\minigamesplashes\dumps\starTiles.dmp" :: @starTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @starMap:
    .incbin "graphics\minigamesplashes\dumps\starMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @star_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\star_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @star_multiMap:
    .incbin "graphics\minigamesplashes\dumps\star_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @starPalette:
    .incbin "kp.gba",0x24930C,0x200
.endautoregion

.autoregion :: .align   
    @bounceTiles:
    .incbin "graphics\minigamesplashes\dumps\bounceTiles.dmp" :: @bounceTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @bounceMap:
    .incbin "graphics\minigamesplashes\dumps\bounceMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @bounce_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\bounce_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @bounce_multiMap:
    .incbin "graphics\minigamesplashes\dumps\bounce_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @bouncePalette:
    .incbin "kp.gba",0x25D3F8,0x200
.endautoregion

.autoregion :: .align   
    @hockeyTiles:
    .incbin "graphics\minigamesplashes\dumps\hockeyTiles.dmp" :: @hockeyTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @hockey_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\hockey_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @hockey_multiMap:
    .incbin "graphics\minigamesplashes\dumps\hockey_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @hockeyPalette:
    .incbin "kp.gba",0x24AE38,0x200
.endautoregion

.autoregion :: .align   
    @dotsTiles:
    .incbin "graphics\minigamesplashes\dumps\dotsTiles.dmp" :: @dotsTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @dotsMap:
    .incbin "graphics\minigamesplashes\dumps\dotsMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @dots_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\dots_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @dots_multiMap:
    .incbin "graphics\minigamesplashes\dumps\dots_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @dotsPalette:
    .incbin "kp.gba",0x24C33C,0x200
.endautoregion

.autoregion :: .align   
    @grassTiles:
    .incbin "graphics\minigamesplashes\dumps\grassTiles.dmp" :: @grassTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @grassMap:
    .incbin "graphics\minigamesplashes\dumps\grassMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @grass_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\grass_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @grass_multiMap:
    .incbin "graphics\minigamesplashes\dumps\grass_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @grassPalette:
    .incbin "kp.gba",0x24E1D8,0x200
.endautoregion

.autoregion :: .align   
    @iceTiles:
    .incbin "graphics\minigamesplashes\dumps\iceTiles.dmp" :: @iceTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @iceMap:
    .incbin "graphics\minigamesplashes\dumps\iceMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @ice_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\ice_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @ice_multiMap:
    .incbin "graphics\minigamesplashes\dumps\ice_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @icePalette:
    .incbin "kp.gba",0x24FA5C,0x200
.endautoregion

.autoregion :: .align   
    @skyTiles:
    .incbin "graphics\minigamesplashes\dumps\skyTiles.dmp" :: @skyTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @skyMap:
    .incbin "graphics\minigamesplashes\dumps\skyMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @sky_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\sky_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @sky_multiMap:
    .incbin "graphics\minigamesplashes\dumps\sky_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @skyPalette:
    .incbin "kp.gba",0x250EDC,0x200
.endautoregion

.autoregion :: .align   
    @flipTiles:
    .incbin "graphics\minigamesplashes\dumps\flipTiles.dmp" :: @flipTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @flip_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\flip_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @flip_multiMap:
    .incbin "graphics\minigamesplashes\dumps\flip_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @flipPalette:
    .incbin "kp.gba",0x2526A4,0x200
.endautoregion

.autoregion :: .align   
    @loveTiles:
    .incbin "graphics\minigamesplashes\dumps\loveTiles.dmp" :: @loveTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @love_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\love_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @love_multiMap:
    .incbin "graphics\minigamesplashes\dumps\love_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @lovePalette:
    .incbin "kp.gba",0x254024,0x200
.endautoregion

.autoregion :: .align   
    @fallTiles:
    .incbin "graphics\minigamesplashes\dumps\fallTiles.dmp" :: @fallTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @fallMap:
    .incbin "graphics\minigamesplashes\dumps\fallMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @fall_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\fall_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @fall_multiMap:
    .incbin "graphics\minigamesplashes\dumps\fall_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @fallPalette:
    .incbin "kp.gba",0x255E74,0x200
.endautoregion

.autoregion :: .align   
    @magnetTiles:
    .incbin "graphics\minigamesplashes\dumps\magnetTiles.dmp" :: @magnetTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @magnetMap:
    .incbin "graphics\minigamesplashes\dumps\magnetMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @magnet_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\magnet_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @magnet_multiMap:
    .incbin "graphics\minigamesplashes\dumps\magnet_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @magnetPalette:
    .incbin "kp.gba",0x25795C,0x200
.endautoregion

.autoregion :: .align   
    @raceTiles:
    .incbin "graphics\minigamesplashes\dumps\raceTiles.dmp" :: @raceTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @raceMap:
    .incbin "graphics\minigamesplashes\dumps\raceMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @race_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\race_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @race_multiMap:
    .incbin "graphics\minigamesplashes\dumps\race_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @racePalette:
    .incbin "kp.gba",0x2593E8,0x200
.endautoregion

.autoregion :: .align   
    @shootTiles:
    .incbin "graphics\minigamesplashes\dumps\shootTiles.dmp" :: @shootTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @shootMap:
    .incbin "graphics\minigamesplashes\dumps\shootMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @shoot_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\shoot_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @shoot_multiMap:
    .incbin "graphics\minigamesplashes\dumps\shoot_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @shootPalette:
    .incbin "kp.gba",0x25A628,0x200
.endautoregion

.autoregion :: .align   
    @twinTiles:
    .incbin "graphics\minigamesplashes\dumps\twinTiles.dmp" :: @twinTilesEnd: :: pad
.endautoregion        

.autoregion :: .align
    @twinMap:
    .incbin "graphics\minigamesplashes\dumps\twinMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @twin_challengeMap:
    .incbin "graphics\minigamesplashes\dumps\twin_challengeMap.dmp" :: pad
.endautoregion


.autoregion :: .align
    @twin_multiMap:
    .incbin "graphics\minigamesplashes\dumps\twin_multiMap.dmp" :: pad
.endautoregion



.autoregion :: .align
    @twinPalette:
    .incbin "kp.gba",0x25BDE8,0x200
.endautoregion
