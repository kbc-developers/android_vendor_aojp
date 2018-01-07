#!/bin/bash

#export USE_CCACHE=1
#export CCACHE_DIR=~/.ccache
#for jenkins

PRODUCT=$1

export TARGET_RECOVERY=twrp
export WITH_TWRP=true
export PLATFORM_SDK_VERSION=26
export TWRP_VERSION=`grep "#define TW_MAIN_VERSION_STR" bootable/recovery-twrp/variables.h | awk '{print $3;}' |sed -e s/\"//g`
export OUT_DIR=$(pwd)/out_twrp


./build.sh $PRODUCT recoveryimage ${@:2}

if [ ! "${OUT_DIR}" ]; then
  cd out/target/product/${PRODUCT}
else
  cd ${OUT_DIR}/target/product/${PRODUCT}
fi
tar cf twrp-${TWRP_VERSION}-0-${PRODUCT}.img.tar recovery.img
cd -

