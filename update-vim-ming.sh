#!/bin/bash
pushd vim
git fetch & git pull
pushd src

mingw32-make -f Make_ming.mak \
	CC=clang \
	OPTIMIZED=MAXSPEED \
	ARCH=x86-64 \
	WINVER=0x0A00 \
	PYTHON3=/c/Python/Python311 \
	PYTHON3_VER=311 \
	COLOR_EMOJI=yes \
	DIRECTX=yes \
	LUA=/c/Users/sooop.QXP/scoop/apps/lua/current \
	LUA_VER=54 \
	GUI=no \
	vim.exe

mingw32-make -f Make_ming.mak \
	CC=clang \
	OPTIMIZED=MAXSPEED \
	ARCH=x86-64 \
	WINVER=0x0A00 \
	PYTHON3=/c/Python/Python311 \
	PYTHON3_VER=311 \
	COLOR_EMOJI=yes \
	DIRECTX=yes \
	LUA=/c/Users/sooop.QXP/scoop/apps/lua/current \
	LUA_VER=54 \
	GUI=yes \
	gvim.exe

popd
popd
