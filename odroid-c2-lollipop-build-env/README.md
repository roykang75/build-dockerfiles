# Docker for odroid-c2 lollipop build environment

**MAKE Docker image**  
```
docker build --tag odroid-c2-lollipop-build-env:0.2 .
```

**Docker Run**  
```
docker run -it --name odroid-c2-lollipop-build-env --restart always --volume /home/roy:/home/roy --volume /etc/passwd:/etc/passwd --volume /work/src:/work/src --volume /etc/localtime:/etc/localtime:ro odroid-c2-lollipop-build-env:0.2
```

**Build account**  
docker image에서 생성한 계정과 Machine의 ubuntu의 계정의 UID/GID가 동일하도록 한다.  
```
$ sudo cat /etc/passwd
...
roy:x:1000:1000:roy,,,:/home/roy:/bin/bash
...
```
**Build android using docker lollipop-build-env:0.1**  
roy 계정의 UID가 1000 일때, 아래와 같이 명령을 내리면 roy 계정으로 로그인하여 build.sh를 실행한다.
```
docker exec -u 1000 -it odroid-c2-lollipop-build-env bash /work/src/c2/s905_5.1.1/run_build.sh
````

**run_build.sh**
```
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
```
