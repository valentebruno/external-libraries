# freeglut
# ======

sed '/-mandroid/d' -i src/$1/CMakeLists.txt
sed '/-gstabs+/d' -i src/$1/CMakeLists.txt
export CMAKE_ADDITIONAL_ARGS="${CMAKE_ADDITIONAL_ARGS} -DFREEGLUT_GLES:BOOL=ON"
source linux/$(basename $0)
