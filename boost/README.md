Boost Windows
=============
This document provides the instructions that were used to build boost 1.59.0 for Windows.

Building Boost
==============
The instructions below provide the steps used for building both 64-bit and 32-bit versions of boost, with both debug and release flavors being built. They were tailored after the instructions for [building boost for Windows](http://www.boost.org/doc/libs/1_59_0/more/getting_started/windows.html) provided on the boost website.

* Download the [source code](http://iweb.dl.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.zip) from the boost website.
* Unzip the contents of the ZIP file into `C:\`. This should produce a diretory called `boost_1_59_0` under `C:\`.
* Start a new DOS command shell, and type (alternatively, `call` [this script](build-boost.cmd)):
```
cd C:\boost_1_59_0
call bootstrap.bat
mkdir build64
b2 --without-mpi --without-python --build-dir=build64 --prefix=C:\Libraries-x64_vc14\boost_1_59_0\ variant=debug variant=release link=static runtime-link=shared architecture=x86 address-model=64 toolset=msvc-14.0 install
cd C:\Libraries-x64_vc14\boost_1_59_0\include
rename boost-1_59 boost
```
* Now create the 32-bit build. From the same command prompt, type:
```
cd C:\boost_1_59_0
mkdir build32
b2 --without-mpi --without-python --build-dir=build32 --prefix=C:\Libraries-x86_vc14\boost_1_59_0\ variant=debug variant=release link=static runtime-link=shared architecture=x86 toolset=msvc-14.0 install
cd C:\Libraries-x86_vc14\boost_1_59_0\include
rename boost-1_59 boost
```

These commands were written with the assumption that you are installing the 64-bit libraries into `C:\Libraries-x64_vc14\`, and the 32-bit libraries into `C:\Libraries-x86_vc14\`.
