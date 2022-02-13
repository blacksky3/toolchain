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

# build

cd glibc-git && makepkg -si && cd ${source}

cd valgrind-git && makepkg -si && cd ${source}

cd binutils-git && makepkg -si && cd ${source}

cd gcc-git && makepkg -si && cd ${source}

cd libtool-git && makepkg -si && cd ${source}

cd lib32-libltd-git && makepkg -si && cd ${source}

# move build package in old directory

cp glibc-git glibc-git.old

cp valgrind-git valgrind-git.old

cp binutils-git binutils-git.old

cp gcc-git binutils-git.old

cp libtool-git binutils-git.old

cp lib32-libltd-git lib32-libltd-git.old

# cleanup original build dir

rm -rf glibc-git/*.pkg.tar.zst
rm -rf glibc-git/pkg/
rm -rf glibc-git/src/

rm -rf valgrind-git/*.pkg.tar.zst
rm -rf valgrind-git/pkg/
rm -rf valgrind-git/src/

rm -rf binutils-git/*.pkg.tar.zst
rm -rf binutils-git/pkg/
rm -rf binutils-git/src/

rm -rf gcc-git/*.pkg.tar.zst
rm -rf gcc-git/pkg/
rm -rf gcc-git/src/

rm -rf libtool-git/*.pkg.tar.zst
rm -rf libtool-git/pkg/
rm -rf libtool-git/src/

rm -rf lib32-libltd-git/*.pkg.tar.zst
rm -rf lib32-libltd-git/pkg/
rm -rf lib32-libltd-git/src/

# recompile toolchain

cd glibc-git && makepkg -si && cd ${source}

cd valgrind-git && makepkg -si && cd ${source}

cd binutils-git && makepkg -si && cd ${source}

cd gcc-git && makepkg -si && cd ${source}

cd libtool-git && makepkg -si && cd ${source}

cd lib32-libltd-git && makepkg -si && cd ${source}

# make a copy of every pkg in package dir

mkdir -p package

cp -v glibc-git/*.pkg.tar.zst package/

cp -v valgrind-git/*.pkg.tar.zst package/

cp -v binutils-git/*.pkg.tar.zst package/

cp -v gcc-git/*.pkg.tar.zst package/

cp -v libtool-git/*.pkg.tar.zst package/

cp -v lib32-libltd-git/*.pkg.tar.zst package/

# clean build dir

rm -rf */src/
rm -rf */pkg/
rm -rf */*/src/
rm -rf */*/pkg/
