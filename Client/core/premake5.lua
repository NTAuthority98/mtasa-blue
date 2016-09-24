project "Client Core"
	language "C++"
	kind "SharedLib"
	targetname "core"
	targetdir(buildpath("mta"))
	
	filter "system:windows"
		includedirs { "../../vendor/sparsehash/current/src/windows" }
		linkoptions { "/SAFESEH\:NO", "\"/manifestdependency:type='win32' name='Microsoft.Windows.Common-Controls' version='6.0.0.0' processorArchitecture='*' publicKeyToken='6595b64144ccf1df' language='*'\"" }
		buildoptions { "-Zm130" }
	
	filter {}
		includedirs { 
			".",
			"../sdk",
			"../../vendor/cef3",
			"../../vendor/tinygettext",
			"../../vendor/zlib",
			"../../vendor/jpeg-9b",
			"../../vendor/pthreads/include",
			"../../vendor/sparsehash/current/src/"
		}

	libdirs {
		"../../vendor/detours/lib",
		"../../vendor/cef3/Release"
	}
	

	pchheader "StdInc.h"
	pchsource "StdInc.cpp"
	
	vpaths { 
		["Headers/*"] = "**.h",
		["Sources/*"] = "**.cpp",
		["Resources/*"] = {"**.rc", "../launch/resource/mtaicon.ico"},
		["*"] = "premake5.lua"
	}
	
	files {
		"premake5.lua",
		"../launch/resource/mtaicon.ico",
		"core.rc",
		"**.h",
		"**.cpp"
	}

	links {
		"ws2_32", "d3dx9", "Userenv", "DbgHelp", "xinput", "Imagehlp", "dxguid", "dinput8", 
		"strmiids",	"odbc32", "odbccp32", "shlwapi", "winmm", "gdi32", "Imm32", "Psapi", 
		"pthread", "libpng", "jpeg", "zlib", "tinygettext", "libcef", "CEF", "detours"
	}

	defines {
		"INITGUID",
		"_WIN32_WINNT=0x601",
		"PNG_SETJMP_NOT_SUPPORTED"
	}

	filter "architecture:x64"
		flags { "ExcludeFromBuild" } 
		
	filter "system:not windows"
		flags { "ExcludeFromBuild" } 
