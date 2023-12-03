@echo off

copy kp.gba kp_patched.gba

:: Need to extract multiplayer payload AND decompress it
:: Replace data with translated images
:: Then re-compress it to re-insert in the ROM
:: Need separate armips operations
mkdir build
fsutil file createnew build/multipayload1.bin 0
armips.exe extractmulti.asm
lzss -d build/multipayload1.bin


:: armips.exe main.asm

pause