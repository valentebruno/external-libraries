cd C:\boost_1_59_0
call bootstrap.bat
mkdir build64
b2 --without-mpi --without-python --build-dir=build64 --prefix=C:\Libraries-x64_vc14\boost_1_59_0\ variant=debug variant=release link=static runtime-link=shared architecture=x86 address-model=64 toolset=msvc-14.0 install
cd C:\Libraries-x64_vc14\boost_1_59_0\include
rename boost-1_59 boost
cd C:\boost_1_59_0
mkdir build32
b2 --without-mpi --without-python --build-dir=build32 --prefix=C:\Libraries-x86_vc14\boost_1_59_0\ variant=debug variant=release link=static runtime-link=shared architecture=x86 toolset=msvc-14.0 install
cd C:\Libraries-x86_vc14\boost_1_59_0\include
rename boost-1_59 boost
