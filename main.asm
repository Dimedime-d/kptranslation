.gba				; Set the architecture to GBA 
.open "kp_patched.gba",0x08000000	; Open input.gba for output.
					; 0x08000000 will be used as the
					; header size

; ROM expansion no more! It fits in 8 MB.

VERSION equ "1.1.1" ; entering a level overwrites lowercase ascii characters in VRAM -_-

;include all assembly files in here
;file paths are relative to armips.exe
.ifdef __DEBUG__
    .warning "Debug flag is ON"
    ; .include "asm/debug.asm" deprecated, hook is now located in vwfalpha.asm like all the other hooks
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
