
# SFML
# ====

SFML_VERSION="2.1"
if [ ! -f SFML-${SFML_VERSION}-sources.zip ]; then
  curl -O http://www.sfml-dev.org/download/sfml/${SFML_VERSION}/SFML-${SFML_VERSION}-sources.zip
fi
rm -fr SFML-${SFML_VERSION}
unzip -x SFML-${SFML_VERSION}-sources.zip
cd SFML-${SFML_VERSION}
patch -p0 <<"SFML_MAC_MEMORY_LEAK"
--- src/SFML/Window/OSX/SFApplication.m
+++ src/SFML/Window/OSX/SFApplication.m
@@ -39,6 +39,7 @@
     [SFApplication sharedApplication]; // Make sure NSApp exists
     NSEvent* event = nil;

+    @autoreleasepool {
     while ((event = [NSApp nextEventMatchingMask:NSAnyEventMask
                                        untilDate:[NSDate distantPast]
                                           inMode:NSDefaultRunLoopMode
@@ -46,6 +47,7 @@
     {
         [NSApp sendEvent:event];
     }
+    }
 }

 - (void)sendEvent:(NSEvent *)anEvent
SFML_MAC_MEMORY_LEAK
mkdir build
cd build
cmake .. -DCMAKE_CXX_FLAGS:STRING="-stdlib=libc++" -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release -DCMAKE_INSTALL_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/SFML-${SFML_VERSION}" -DCMAKE_INSTALL_FRAMEWORK_PREFIX:PATH="${EXTERNAL_LIBRARY_DIR}/SFML-2.1/Frameworks" -DCMAKE_OSX_ARCHITECTURES:STRING="x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET:STRING=10.10 -DCMAKE_OSX_SYSROOT:PATH=macosx10.9
make -j 4 && make install/strip
cmake .. -DBUILD_SHARED_LIBS:BOOL=OFF
make -j 4 && make install/strip && cp ../extlibs/libs-osx/lib/lib*.a "${EXTERNAL_LIBRARY_DIR}/SFML-${SFML_VERSION}/lib/"
cd ..
