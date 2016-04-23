cd $1/../src

cd $2
cd nss

set OS_TARGET=WIN95
set USE_64=1
set BUILD_OPT=0
make nss_build_all

#set BUILD_OPT=1
#make nss_build_all

echo args=$@
