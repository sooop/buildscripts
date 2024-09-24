def "console-log" [
	msg: string
	--color: string = "lyr"
	] {
		echo $"\(ansi ($color)\)($msg)(ansi reset)"
}


def get-config [filename='vimcfg.toml'] {
	if ( $filename | path exists ) {
		let cfg = ($filename | path expand | open | get DEFAULT)
		return $cfg
	} else {
		let pyver = 312
		let pydrv = 'C'
		let cfg = {
			pyver: $pyver,
			pydrv: $pydrv,
			pydir: $"($pydrv):/Python/Python($pyver)/",
			luadir: 'D:/scoop/apps/lua/current/',
			luaver: 54,
			arch: 'x86-64',
			winver: '0x0A00',
			vimdir: "C:/Program Files/vim/vim91"
		}
		return $cfg
	}
}


def "build-options" [
	cfg
	--gui(-g)] {
	let options = [
		CC=clang
        OPTIMIZE=SPEED
		$"ARCH=($cfg.arch)"
        $"WINVER=($cfg.winver)"
		$"PYTHON3=($cfg.pydir)"
        $"PYTHON3_VER=($cfg.pyver)"
		$"LUA=($cfg.luadir)"
        $"LUA_VER=($cfg.luaver)"
	]
	if ($gui) {
		return ($options | append [
			"DIRECTX=YES",
			"COLOR_EMOJI=YES",
			"OLE=NO",
			"gvim.exe"])
	} else {
		return ($options | append [
		"GUI=no",
		"vim.exe"])
	}
}


def copy-result [
	cfg
	vimdir
] {
	if not (ls | where name =~ "exe$" | is-empty) {
		ls *.exe | each { |it|
			print $"(ansi ur)copying ($it.name) to vim directory...[($vimdir)](ansi reset)"
			cp $it.name $cfg.vimdir
		}
	} else {
		print "No executable files"
	}
}


def main [
	--pull(-p)
	--build(-b)
	--copy(-c)
	] {
	# get default build settings
	let cfg = (get-config)

	if $copy {
		print "--copy is given"
		copy-result $cfg
		return
	}

	let p = $pull
    do {
    	cd vim
    	echo $env.PWD
    	echo $p
    	if ($p) {
            print $"(ansi lyr)Update repository...(ansi reset)"
    		git fetch ; git pull
    	}
    	do {
    		cd src
    		echo $env.PWD
    		print $"(ansi lyr)Clean workspace(ansi reset)"
    		mingw32-make -f Make_ming.mak clean
    		for dirx in [objx86-64 objx86-64] {
    			if ($dirx | path exists) {
    				rm -rf $dirx
    			}
    		}

    		print $"(ansi lyr)Build vim CLI\(vim.exe)(ansi reset)"
    		($cfg | build-options $in) | mingw32-make -f Make_ming.mak $in
    		print $"(ansi lyr)Build vim GUI\(gvim.exe)(ansi reset)"
    		($cfg | build-options -g $in) | mingw32-make -f Make_ming.mak $in
    		print

    		if (not $build) and (ls | where name =~ 'exe$' | is-empty) {
    		} else {
    			ls *.exe | each { |it|
    				echo $"(ansi ur)copying ($it.name) to vim directory...[($cfg.vimdir)](ansi reset)"
    				cp $it.name $cfg.vimdir
    			}
    		}
    	} # end of inner do
    	print $"(ansi lyr)Copying runtime files(ansi reset)"
    	cp -r runtime/* $cfg.vimdir
    } # end of outer do
	print $"(ansi lyr)Done(ansi reset)"
}
