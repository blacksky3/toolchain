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

# prepare

# makepkg --verifysource to grap same version for package stage1/stage2 build

cd linux-api-headers-git && makepkg --verifysource && cd ${source}

cd glibc && makepkg --verifysource && cd ${source}

cd binutils && makepkg --verifysource && cd ${source}

cd gcc-git && makepkg --verifysource && cd ${source}

# create stage 1 build dir

if ! dir glibc-stage1; then
  cp -r glibc glibc-stage1
fi

if ! dir binutils-stage1; then
  cp -r binutils binutils-stage1
fi

if ! dir gcc-git-stage1; then
  cp -r gcc-git gcc-git-stage1
fi

# create stage 2 build dir

if ! dir glibc-stage2; then
  cp -r glibc glibc-stage2
fi

if ! dir binutils-stage2; then
  cp -r binutils binutils-stage2
fi

if ! dir gcc-git-stage2; then
  cp -r gcc-git gcc-git-stage2
fi

# build linux-api-headers

cd linux-api-headers-git && makepkg -si && cd ${source}

# build stage1

cd glibc-stage1 && makepkg -si --nocheck && cd ${source}

cd binutils-stage1 && makepkg -si --nocheck && cd ${source}

cd gcc-git-stage1 && makepkg -si --nocheck && cd ${source}

# build stage2

cd glibc-stage2 && makepkg -si && cd ${source}

cd binutils-stage2 && makepkg -si && cd ${source}

cd gcc-git-stage2 && makepkg -si && cd ${source}

# make a copy of every pkg in package dir

mkdir -p package

cp -v linux-api-headers-git/*.pkg.tar.zst package/

cp -v glibc-stage2/*.pkg.tar.zst package/

cp -v binutils-stage2/*.pkg.tar.zst package/

cp -v gcc-git-stage2/*.pkg.tar.zst package/

# clean build dir

rm -rf */src/
rm -rf */pkg/
rm -rf */*/src/
rm -rf */*/pkg/
