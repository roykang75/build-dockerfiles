#!/bin/bash

cd /work/src/pf-pro
echo "rm -rf out"
rm -rf out

if [ -d .repo ]; then
	repo forall -c 'pwd; git clean -xdf; git reset HEAD --hard'
else
	echo "There is no repo"
	exit -1;
fi

repo init -u ssh://git@gitlab.com/pettra/android/platform/manifest.git -b master-pf --depth=1

repo sync -c -j20 --no-tags

./device/nexell/tools/build.sh -b s5p6818_rookie

buildResult=`date +%Y-%m-%d_%H-%M`.tar
tar -cvf ${buildResult} ./result
cp *.tar /work/buildResult
rm -rf *.tar