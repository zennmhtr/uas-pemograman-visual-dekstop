@echo off
SET THEFILE=C:\UAS_PEMROGRAMAN_VISUAL\UAS_PEMROGRAMAN_VISUAL\backup\project1.exe
echo Linking %THEFILE%
D:\lazarus\fpc\3.2.2\bin\x86_64-win64\ld.exe -b pei-x86-64  --gc-sections   --subsystem windows --entry=_WinMainCRTStartup    -o C:\UAS_PEMROGRAMAN_VISUAL\UAS_PEMROGRAMAN_VISUAL\backup\project1.exe C:\UAS_PEMROGRAMAN_VISUAL\UAS_PEMROGRAMAN_VISUAL\backup\link9020.res
if errorlevel 1 goto linkend
goto end
:asmend
echo An error occurred while assembling %THEFILE%
goto end
:linkend
echo An error occurred while linking %THEFILE%
:end
