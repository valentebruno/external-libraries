#!/bin/bash
exec > >(tee -i $EXT_LIB_INSTALL_ROOT/build.log)
exec 2>&1
