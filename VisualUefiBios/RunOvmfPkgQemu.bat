@echo off

set ARCHITECTURE=%1
set CONFIGURATION=%2

if defined VS160COMNTOOLS (
	set TOOL_SET=VS2019
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
