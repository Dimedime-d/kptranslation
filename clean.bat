@echo off

set OutFile=kp_patched.gba

rmdir build /s /q
echo "[INFO] Deleted build/"
copy kp.gba %OutFile%
echo "[INFO] Overwrote %OutFile% with a fresh rom"
pause