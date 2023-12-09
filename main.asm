.gba				; Set the architecture to GBA 
.open "kp_patched.gba",0x08000000	; Open input.gba for output.
					; 0x08000000 will be used as the
					; header size

; move region directive here, originally was in vwfalpha.asm
.org 0x08800000	;padding to extend the ROM
.region 0x0800000,00
.endregion

;include all assembly files in here
;file paths are relative to armips.exe
.definelabel __DEBUG__, 1
.ifdef __DEBUG__
    .warning "Debug flag is ON"
    .include "asm/debug.asm"
.endif

.include "graphics/menu/menumacros.asm" ; avoid repeated defines

.include "multi/insertmulti.asm" ; should require no free space, so okay to put this anywhere?

.include "asm/customcode.asm"
.include "asm/vwfalpha.asm"
.include "graphics/learnmagic/binaries.asm"
.include "text/insertscripts.asm"
.include "text/ascii.asm"
.include "text/menu.asm"
.include "graphics/glyphs/glyphbinaries.asm"
.include "graphics/minigamesplashes/minigamesplashes.asm"
.include "graphics/minigamesplashes/overworldsplashes.asm"
.include "graphics/minigamesplashes/titlescreen.asm"
.include "graphics/overworldtitles/overworldtitles.asm"
.include "graphics/inlevel/inleveltext.asm"
.include "graphics/menu/1Pmenus.asm"
.include "graphics/fixed/fixedgraphics.asm"

.close
