.gba				; Set the architecture to GBA 
.open "kp_patched.gba",0x08000000	; Open input.gba for output.
					; 0x08000000 will be used as the
					; header size
					
;include all assembly files in here
;file paths are relative to armips.exe
.include "asm/customcode.asm"
.include "asm/vwfalpha.asm"
.include "text/insertscripts.asm"
.include "text/ascii.asm"
.include "text/menu.asm"
.include "graphics/minigamesplashes/minigamesplashes.asm"
.include "graphics/minigamesplashes/overworldsplashes.asm"
.include "graphics/overworldtitles/overworldtitles.asm"
.include "graphics/inlevel/inleveltext.asm"
.include "graphics/menu/menumacros.asm"
.include "graphics/menu/1Pmenus.asm"

.close
