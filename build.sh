# _     _            _        _          _____
#| |__ | | __ _  ___| | _____| | ___   _|___ /
#| '_ \| |/ _` |/ __| |/ / __| |/ / | | | |_ \
#| |_) | | (_| | (__|   <\__ \   <| |_| |___) |
#|_.__/|_|\__,_|\___|_|\_\___/_|\_\\__, |____/
#                                  |___/

#Maintainer: blacksky3 <blacksky3@tuta.io> <https://github.com/blacksky3>

# toolchain build order: linux-api-headers->glibc->binutils->gcc->glibc->binutils->gcc
# NOTE: valgrind requires rebuilt with each major glibc version
# NOTE: libtool requires rebuilt with each new gcc version

#!/bin/bash

source=$(pwd)

echo "${source}"

# build linux-api-headers

cd linux-api-headers-git && makepkg -si && cd ${source}

# creaye stage 1 build dir

cp -r glibc-git glibc-git-stage1

cp -r valgrind-git valgrind-git-stage1

cp -r binutils-git binutils-git-stage1

cp -r gcc-git gcc-git-stage1

cp -r libtool-git libtool-git-stage1

cp -r lib32-libltdl-git lib32-libltd-git-stage1

# create stage 2 build dir

cp -r glibc-git glibc-git-stage2

cp -r valgrind-git valgrind-git-stage2

cp -r binutils-git binutils-git-stage2

cp -r gcc-git gcc-git-stage2

cp -r libtool-git libtool-git-stage2

cp -r lib32-libltdl-git lib32-libltd-git-stage2

# build stage1

cd glibc-git-stage1 && makepkg -si --nocheck && cd ${source}

cd valgrind-git-stage1 && makepkg -si --nocheck && cd ${source}

cd binutils-git-stage1 && makepkg -si --nocheck && cd ${source}

cd gcc-git-stage1 && makepkg -si --nocheck && cd ${source}

cd libtool-git-stage1 && makepkg -si --nocheck && cd ${source}

cd lib32-libltdl-git-stage1 && makepkg -si --nocheck && cd ${source}

# build stage2

cd glibc-git-stage2 && makepkg -si --nocheck && cd ${source}

cd valgrind-git-stage2 && makepkg -si --nocheck && cd ${source}

cd binutils-git-stage2 && makepkg -si --nocheck && cd ${source}

cd gcc-git-stage2 && makepkg -si --nocheck && cd ${source}

cd libtool-git-stage2 && makepkg -si --nocheck && cd ${source}

cd lib32-libltdl-git-stage2 && makepkg -si --nocheck && cd ${source}

# make a copy of every pkg in package dir

mkdir -p package

cp -v glibc-git-stage2/*.pkg.tar.zst package/

cp -v valgrind-git-stage2/*.pkg.tar.zst package/

cp -v binutils-git-stage2/*.pkg.tar.zst package/

cp -v gcc-git-stage2/*.pkg.tar.zst package/

cp -v libtool-git-stage2/*.pkg.tar.zst package/

cp -v lib32-libltdl-git-stage2/*.pkg.tar.zst package/

# clean build dir

rm -rf */src/
rm -rf */pkg/
rm -rf */*/src/
rm -rf */*/pkg/
