@echo off

set DebugVar=0
set Debug="-definelabel __DEBUG__ 1"

set InFile=kp.gba
set OutFile=kp_patched.gba

copy kp.gba kp_patched.gba

:: Need to extract multiplayer payload AND decompress it
:: Replace data with translated images
:: Then re-compress it to re-insert in the ROM
:: Need separate armips operations
echo "[INFO] Extracting Multiplayer payloads..."
mkdir build

set PayloadFile1=build/multipayload1.bin
if not exist "%PayloadFile1%" (
	fsutil file createnew "%PayloadFile1%" 0
)
set PayloadFile2=build/multipayload2.bin
if not exist "%PayloadFile2%" (
	fsutil file createnew "%PayloadFile2%" 0
)
set PayloadFile3=build/multipayload3.bin
if not exist "%PayloadFile3%" (
	fsutil file createnew "%PayloadFile3%" 0
)

armips.exe multi/payload/extractmulti.asm
lzss -d "%PayloadFile1%"
lzss -d "%PayloadFile2%"
lzss -d "%PayloadFile3%"
echo "[INFO] Patching Multiplayer payloads..."
armips.exe multi/payload/modifymulti.asm
lzss -ewo "%PayloadFile1%"
lzss -ewo "%PayloadFile2%"
lzss -ewo "%PayloadFile3%"

echo "[INFO] Patching game, please wait..."

if %DebugVar% NEQ 0 (
	armips.exe main.asm -sym "kp_patched.sym" "%Debug%" -stat
) else (
	armips.exe main.asm -sym "kp_patched.sym" -stat
)

if %errorlevel% NEQ 0 (
	echo "ERROR: Armips could not build the ROM."
	del %OutFile%
) else (
echo "[INFO] Patching is done"
)

pause