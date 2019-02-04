#!/bin/bash
export ARCH=arm64
export CROSS_COMPILE=aarch64-none-elf-
export PATH=/opt/toolchains/gcc-linaro-aarch64-none-elf-4.9-2014.09_linux/bin:$PATH
export PATH=/opt/toolchains/gcc-linaro-arm-none-eabi-4.8-2014.04_linux/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH

source build/envsetup.sh
lunch odroidc2-eng-32
make update-api && make -j8 selfinstall
