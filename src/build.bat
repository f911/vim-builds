:: command to build big Vim 64 bit with OLE, Perl and Python.
:: First run: %VCDIR%\vcvarsall.bat x86_amd64
:: Ruby, Tcl and Perl are excluded, doesn't seem to work / build.

::SET VCDIR="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\"
::SET VCDIR="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\amd64"

@ECHO OFF

:: -----------------------------------------------
::   1. set and get environment variables
:: -----------------------------------------------
SET SRCDIR=%~dp0
SET MSDIR="C:\Program Files (x86)\Microsoft Visual Studio 14.0"
SET VCDIR="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64"
SET XPM=xpm\x64

CALL %MSDIR%\Common7\Tools\VsDevCmd.bat
CALL %VCDIR%\vcvars64.bat

CD /d %SRCDIR%


:: -----------------------------------------------=
::   2. make gvim.exe
:: -----------------------------------------------=
DEL /S /Q %SRCDIR%\ObjGOHAMD64\
DEL /F /Q gvim.exe

%VCDIR%\nmake -f Make_mvc.mak SDK_INCLUDE_DIR="C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include" FEATURES=HUGE CPU=AMD64 GUI=yes OLE=yes DIRECTX=yes PERL=C:\Perl64 DYNAMIC_PERL=yes PERL_VER=524 PYTHON=C:\Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=C:\Python36 DYNAMIC_PYTHON3=yes PYTHON3_VER=36 IME=yes GIME=yes CSCOPE=yes USERNAME=shiki USERDOMAIN=NERV

IF EXIST gvim.exe (
ECHO.
ECHO     [+] MAKE gvim.exe SUCCESS!
ECHO.
) ELSE (
ECHO.
ECHO     [-] MAKE gvim.exe FAILED! Please check makefile arguments.
ECHO.
)
pause

:: ------------------------------------------------
::   3. make vim.exe
:: ------------------------------------------------
DEL /S /Q %SRCDIR%\ObjCOHAMD64\
DEL /F /Q vim.exe

%VCDIR%\nmake -f Make_mvc.mak SDK_INCLUDE_DIR="C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include" FEATURES=HUGE CPU=AMD64 GUI=no OLE=yes DIRECTX=yes PERL=C:\Perl64 DYNAMIC_PERL=yes PERL_VER=524 PYTHON=C:\Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=C:\Python36 DYNAMIC_PYTHON3=yes PYTHON3_VER=36 IME=yes GIME=yes CSCOPE=yes USERNAME=shiki USERDOMAIN=NERV

IF EXIST vim.exe (
ECHO.
ECHO     [+] MAKE vim.exe SUCCESS!
ECHO.
) ELSE (
ECHO.
ECHO     [-] MAKE vim.exe FAILED! Please check makefile arguments.
ECHO.
)
pause


:: ------------------------------------------------
::   4. install or reinstall vim8.0
:: ------------------------------------------------
set VIMDIR=%SRCDIR%\..\..\..\vim

:: TODO: uninstall previous vim version.
if exist %VIMDIR%\vim80\uninstal.exe (
    echo.
    echo [+] Now uninstall the previous version of vim. 
    call uninstall.exe
    echo.
) else (
    echo.
    echo [+] Seem not install yet.
    echo.
)

if exist %VIMDIR% (
    del /f /s /q %VIMDIR%\*
) else (
    md %VIMDIR%
)
md %VIMDIR%\vim80
xcopy /s /q %SRCDIR%\..\runtime\*  %VIMDIR%\vim80
copy %SRCDIR%\*.exe %VIMDIR%\vim80
copy %SRCDIR%GvimExt\gvimext.dll %VIMDIR%\vim80
copy %SRCDIR%xxd\xxd.exe %VIMDIR%\vim80

:: vim: se ai si nowrap ft=dosbash
:: EOF
