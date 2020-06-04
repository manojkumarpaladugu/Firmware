@echo off

set ARCHITECTURE=%1
set CONFIGURATION=%2

if not defined QEMU (
  echo Error: QEMU not found. Please install QEMU and set envrionment variable under System Variable category
  exit /b 1
)

if defined VS160COMNTOOLS (
  set TOOL_SET=VS2019
) else if defined VS150COMNTOOLS (
  set TOOL_SET=VS2017
) else if defined VS140COMNTOOLS (
  set TOOL_SET=VS2015x86
) else if defined VS120COMNTOOLS (
  set TOOL_SET=VS2013x86
) else (
  echo Error: Build\Ovmf%ARCHITECTURE%\%CONFIGURATION%_%TOOL_SET%\FV\OVMF.fd may not be available
  exit /b 1
)

if not exist %cd%/logs (
  mkdir logs
)

if "%CONFIGURATION%" == "DEBUG" (
  "%QEMU%\qemu-system-x86_64" -drive file=fat:rw:Build\OvmfX64\%CONFIGURATION%_%ARCHITECTURE%\X64,format=raw -debugcon file:logs/OvmfPkg_%ARCHITECTURE%_%CONFIGURATION%.log -global isa-debugcon.iobase=0x402 -net none -bios Build\Ovmf%ARCHITECTURE%\%CONFIGURATION%_%TOOL_SET%\FV\OVMF.fd
  exit /b 0
)

if "%CONFIGURATION%" == "RELEASE" (
  "%QEMU%\qemu-system-x86_64" -drive file=fat:rw:Build\OvmfX64\%CONFIGURATION%_%ARCHITECTURE%\X64,format=raw -net none -bios Build\Ovmf%ARCHITECTURE%\%CONFIGURATION%_%TOOL_SET%\FV\OVMF.fd
  exit /b 0
)

echo Error: Invalid configuration
exit /b 1
