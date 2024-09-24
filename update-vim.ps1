Set-Location "G:\sources"
Write-Host -ForegroundColor yellow "Dive into vim source directory"
pushd vim\src

$vimdir = "C:\Program Files\vim\vim82"
$pyver  = 311
$pydir  = "G:/Python/Python311'
$vwinver = 0x0A00
$varch  = "x86-64"
$luadir = "D:/scoop/apps/lua/current/"
$luaver = 54


Write-Host -ForegroundColor yellow "Cleaning Up the previous outputs"
mingw32-make -f Make_ming.mak clean

Remove-Item *.exe
if (Test-Path -Path objx86-64) { Remove-Item -Force -Recurse objx86-64 }
if (Test-Path -Pkath gobjx86-64) { Remove-Item -Force -Recurse gobjx86-64 }

Write-Host -ForegroundColor yellow "Building vim.exe CLI app."
mingw32-make -f Make_ming.mak `
	CC=clang OPTIMIZE=SPEED `
	ARCH=$varch WINVER=0x0A00 `
	PYTHON3="G:/Python$pyver/" `
	PYTHON3_VER=$pyver `
	GUI=no `
	LUA=$luadir `
	LUA_VER=$luaver `
	vim.exe


Write-Host -ForegroundColor yellow "Building gvim.exe GUI app."
mingw32-make -f Make_ming.mak `
	CC=clang OPTIMIZE=SPEED `
	ARCH=$varch WINVER=0x0A00 `
	PYTHON3="G:/Python$pyver/" `
	PYTHON3_VER=$pyver `
	LUA="D:/scoop/apps/lua/current/" `
	LUA_VER=54 `
	DIRECTX=yes OLE=yes COLOR_EMOJI=yes `
	gvim.exe

pushd ..
Copy-Item -Force -Recurse runtime 'C:\Program Files\Vim\vim82'
popd
popd
