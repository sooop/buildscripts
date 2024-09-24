@echo off
@echo "Dive into vim source directory"
@echo ""
cd /d D:\sources
pushd vim

set compilername=gcc
set vimdir="C:\Program Files\vim\vim91"
set pyv=312
set pythondir=C:/Python/Python%pyv%
set varch=x86-64
set luadir=C:/Users/sooop.QXP/scoop/apps/lua/current
set luaver=54
rem set winver=0x0A00
set winver=0x0601


@echo "Check and Get the latest source from github"
@echo ""
REM git fetch && git pull
@echo "Clean build directory"
@echo ""
pushd src
mingw32-make -f Make_ming.mak clean
@del *.exe
@rd /q/s gobjx86-64
@rd /q/s objx86-64
@echo "Build CLI version (vim.exe)"
@echo ""
mingw32-make -f Make_ming.mak ^
	CC=%compilername% ^
   	OPTIMIZE=MAXSPEED ^
	ARCH=%varch% ^
	WINVER=%winver% ^
	PYTHON3=%pythondir% ^
	PYTHON3_VER=%pyv% ^
	COLOR_EMOJI=yes ^
	DIRECTX=yes ^
	LUA=%luadir% ^
	LUA_VER=%luaver% ^
	GUI=no ^
   	vim.exe
@echo "Build GUI version (gvim.exe)"
@echo ""
mingw32-make -f Make_ming.mak ^
	CC=%compilername% ^
   	OPTIMIZE=MAXSPEED ^
	ARCH=%varch% ^
	WINVER=%winver% ^
	PYTHON3=%pythondir% ^
	PYTHON3_VER=%pyv% ^
	COLOR_EMOJI=yes ^
	DIRECTX=yes ^
	LUA=%luadir% ^
	LUA_VER=%luaver% ^
	GUI=yes ^
   	gvim.exe
@echo "Copy new executables into program folder"
@echo ""

copy /y *.exe %vimdir%
@echo "Copy all new runtime files to program folder"
@echo ""
popd
@rem xcopy /s/y runtime %vimdir%\runtime
popd
@echo "Completed"
@echo ""
@echo on
