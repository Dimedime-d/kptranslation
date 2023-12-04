@echo off

copy kp.gba kp_patched.gba

:: Need to extract multiplayer payload AND decompress it
:: Replace data with translated images
:: Then re-compress it to re-insert in the ROM
:: Need separate armips operations
echo "[INFO] Extracting Multiplayer payloads..."
mkdir build

set PayloadFile1=build/multipayload1.bin
if not exist "%PayloadFile1%" (
	fsutil file createnew build/multipayload1.bin 0
)

armips.exe multi/payload/extractmulti.asm
lzss -d build/multipayload1.bin
armips.exe multi/payload/modifymulti.asm
lzss -ewo build/multipayload1.bin

echo "[INFO] Patching game, please wait..."

armips.exe main.asm

echo "[INFO] Patching is done"

pause