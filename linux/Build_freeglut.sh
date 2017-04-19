# freeglut
# ======

src_dir=$1
ins_dir=$2
echo $src
cd src/${src_dir}

patch -f -p0 <<"FREEGLUT_NO_XRANDR_XF86VM"
--- configure.old 2013-02-12 13:02:05.517823000 -0800
+++ configure 2013-02-12 13:00:48.160776000 -0800
@@ -12229,6 +12229,7 @@
 else
   ac_cv_lib_Xxf86vm_XF86VidModeSwitchToMode=no
 fi
+ac_cv_lib_Xxf86vm_XF86VidModeSwitchToMode=no
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
 LIBS=$ac_check_lib_save_LIBS
@@ -12274,6 +12275,7 @@
 else
   ac_cv_lib_Xrandr_XRRQueryExtension=no
 fi
+ac_cv_lib_Xrandr_XRRQueryExtension=no
 rm -f core conftest.err conftest.$ac_objext \
     conftest$ac_exeext conftest.$ac_ext
 LIBS=$ac_check_lib_save_LIBS
@@ -12550,6 +12552,8 @@
 $as_echo "#define TIME_WITH_SYS_TIME 1" >>confdefs.h

 fi
+ac_cv_header_X11_extensions_xf86vmode_h=no
+ac_cv_header_X11_extensions_Xrandr_h=no

 for ac_header in X11/extensions/xf86vmode.h
 do :
FREEGLUT_NO_XRANDR_XF86VM
./configure --prefix="${ins_dir}" CPPFLAGS="-fPIC"
make && make install
cd ..


# For Freeglut 3.0.0
#CPPFLAGS="-fPIC"
#cmake . -DCMAKE_INSTALL_PREFIX=${ins_dir} -DFREEGLUT_BUILD_DEMOS:BOOL=OFF \
#-DFREEGLUT_BUILD_SHARED_LIBS:BOOL=OFF -DFREEGLUT_BUILD_STATIC_LIBS:BOOL=ON
#
#make -j 9 && make install
