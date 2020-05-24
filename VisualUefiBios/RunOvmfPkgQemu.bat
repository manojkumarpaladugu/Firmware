@echo off

set ARCHITECTURE=%1
set CONFIGURATION=%2

if defined VS160COMNTOOLS (
  set TOOL_SET=VS2019
) else if defined VS150COMNTOOLS (
  set TOOL_SET=VS2017
) else if defined VS140COMNTOOLS (
  set TOOL_SET=VS2015x86
) else if defined VS120COMNTOOLS (
  set TOOL_SET=VS2013x86
) else (
  echo "Error: Build\Ovmf%ARCHITECTURE%\%CONFIGURATION%_%TOOL_SET%\FV\OVMF.fd may not be available"
  exit /b 1
)

cd ..

if not exist %cd%/logs (
  mkdir logs
)
if %CONFIGURATION% == DEBUG (
  qemu-system-x86_64 -debugcon file:logs/OvmfPkg_%ARCHITECTURE%_%CONFIGURATION%.log -global isa-debugcon.iobase=0x402 -net none -bios Build\Ovmf%ARCHITECTURE%\%CONFIGURATION%_%TOOL_SET%\FV\OVMF.fd
) else (
  qemu-system-x86_64 -net none -bios Build\Ovmf%ARCHITECTURE%\%CONFIGURATION%_%TOOL_SET%\FV\OVMF.fd
)
