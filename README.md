# EDK2 UEFI Firmware with QEMU

<pre>
Prerequisites:
  1. Download and install QEMU (https://www.qemu.org/download)
  2. Setup ASL compiler (https://github.com/tianocore/tianocore.github.io/wiki/Asl-Setup)
  3. Setup NASM compiler (https://github.com/tianocore/tianocore.github.io/wiki/Nasm-Setup)
  4. Install Python 2.7.10 or later
</pre>

<pre>
Obtaining source code:
To get a full, buildable repository, use following steps of git command
  git clone https://github.com/manojkumarpaladugu/VisualUefiBios.git
  cd VisualUefiBios
  git submodule update --init
  cd edk2
  git submodule update --init

If there's update for submodules, use following git commands to get the latest submodules code
  cd VisualUefiBios
  git pull
  git submodule update
  cd edk2
  git pull
  git submodule update
</pre>

<pre>
Build & Run:
  1. Open VisualUefiBios.sln
  2. Choose build configuration and build solution
  3. Select Debug -> Start Without Debugging
  4. Check logs folder for bios log
</pre>
