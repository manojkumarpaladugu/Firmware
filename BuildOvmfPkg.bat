@echo off

set ARCHITECTURE=%1
set CONFIGURATION=%2

if defined VS160COMNTOOLS (
  call "%VS160COMNTOOLS%\VsDevCmd.bat"
  set TOOL_SET=VS2019
) else if defined VS150COMNTOOLS (
  call "%VS150COMNTOOLS%\VsDevCmd.bat"
  set TOOL_SET=VS2017
) else if defined VS140COMNTOOLS (
  call "%VS140COMNTOOLS%VsDevCmd.bat"
  set TOOL_SET=VS2015x86
) else if defined VS120COMNTOOLS (
  call "%VS120COMNTOOLS%VsDevCmd.bat"
  set TOOL_SET=VS2013x86
) else (
  echo Error: Compiler not available, exiting now...
  exit /b 1
)

set WORKSPACE=%cd%
set PACKAGES_PATH=%WORKSPACE%\edk2
set NASM_PREFIX=C:\nasm\

cd edk2
if exist %cd%\BaseTools.Ready (
  call edksetup.bat
) else (
  echo off > BaseTools.Ready
  call edksetup.bat Rebuild
)

build -p OvmfPkg/OvmfPkg%ARCHITECTURE%.dsc -D SOURCE_DEBUG_ENABLE=TRUE -a %ARCHITECTURE% -b %CONFIGURATION% -t %TOOL_SET%

cd ..
