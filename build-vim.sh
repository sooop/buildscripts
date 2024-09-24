#!/bin/bash
### Enter vim directory
ppp="$(which vim)"
ppp="${ppp%vim}"
echo "Entering VIM Directory..."
pushd vim
echo
echo
#echo "Update Vim from Remote Repository"
#git fetch && git pull
echo "Entering VIM Source Directory"
pushd src
echo
echo
echo "Clean Build Environment"
mingw32-make clean
rm -rf *.exe
rm -rf obj* gobj*
echo
echo
echo "Build Vim for Non-GUI(vim.exe)"
mingw32-make -f Make_ming.mak \
	CC=gcc OPTIMIZE=SPEED \
	ARCH=x86-64 WINVER=0x0A00 \
	PYTHON3=/c/Python/Python312 \
	PYTHON3_VER=312 \
	LUA=/c/Users/sooop.QXP/scoop/apps/lua/current \
	LUA_VER=54 \
	DIRECTX=yes \
	GUI=no \
	vim.exe
echo
echo
echo "Build Vim for GUI(gvim.exe)"
mingw32-make -f Make_ming.mak \
	CC=gcc OPTIMIZE=SPEED \
	ARCH=x86-64 WINVER=0x0A00 \
	PYTHON3=/c/Python/Python312 \
	PYTHON3_VER=312 \
	LUA=/c/Users/sooop.QXP/scoop/apps/lua/current \
	LUA_VER=54 \
	DIRECTX=yes \
	GUI=yes \
	gvim.exe
### INSTALL
echo
echo
#echo "Install Vim"
#oldifs=$IFS
#IFS='\n'
## echo "Find VIM Install Directories..."
## cp *.exe "$ppp"
#IFS=$oldifs
#echo "Exiting..."
#popd
## echo "Copy runtime files to install target"
## cp -rfv runtime "$ppp"
#popd
