@echo off

if defined VS160COMNTOOLS (
	call "%VS160COMNTOOLS%\VsDevCmd.bat"
	set TOOL_SET=VS2019
) else (
	echo "Compiler not available, exiting now..."
	exit /b 1
)

set ARCHITECTURE=%1
set CONFIGURATION=%2

set CWD=%cd%
echo %CWD%
cd ..
set WORKSPACE=%cd%
set PACKAGES_PATH=%WORKSPACE%\edk2;%WORKSPACE%\edk2-libc
set NASM_PREFIX=C:\nasm\

cd edk2
if exist %cd%\BaseTools.Ready (
	call edksetup.bat
) else (
	echo off > BaseTools.Ready
	call edksetup.bat Rebuild
)

build -p OvmfPkg/OvmfPkg%ARCHITECTURE%.dsc -a %ARCHITECTURE% -b %CONFIGURATION% -t %TOOL_SET%