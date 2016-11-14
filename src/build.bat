:: command to build big Vim 64 bit with OLE, Perl and Python.
:: First run: %VCDIR%\vcvarsall.bat x86_amd64
:: Ruby and Tcl are excluded, doesn't seem to work.

::SET VCDIR="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\"
::SET VCDIR="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\amd64"

@ECHO OFF


:: ===============================================
::
::   1. set and get environment variables
::
:: ===============================================
SET SRCDIR=%~dp0
SET MSDIR="C:\Program Files (x86)\Microsoft Visual Studio 14.0"
SET VCDIR="C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64"
SET XPM=xpm\x64

CALL %MSDIR%\Common7\Tools\VsDevCmd.bat
CALL %VCDIR%\vcvars64.bat

CD /d %SRCDIR%


:: ================================================
::
::   2. make gvim.exe
::
:: ================================================
DEL /S /Q %SRCDIR%\ObjGOHAMD64\
DEL /F /Q gvim.exe

%VCDIR%\nmake -f Make_mvc.mak SDK_INCLUDE_DIR="C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include" FEATURES=HUGE CPU=AMD64 GUI=yes OLE=yes DIRECTX=yes PERL=C:\Perl64 DYNAMIC_PERL=yes PERL_VER=524 PYTHON=C:\Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=C:\Python35 DYNAMIC_PYTHON3=yes PYTHON3_VER=35  %1 IME=yes GIME=yes CSCOPE=yes USERNAME=nick USERDOMAIN=TSUKIHIME

IF EXIST gvim.exe (
ECHO.
ECHO     [+] MAKE gvim.exe SUCCESS!
ECHO.
) ELSE (
ECHO.
ECHO     [-] MAKE gvim.exe FAILED! Please check makefile arguments.
ECHO.
)


:: ================================================
::
::   3. make vim.exe
::
:: ================================================
DEL /S /Q %SRCDIR%\ObjGOHAMD64\
DEL /F /Q vim.exe

%VCDIR%\nmake -f Make_mvc.mak SDK_INCLUDE_DIR="C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include" FEATURES=HUGE CPU=AMD64 GUI=no OLE=yes DIRECTX=yes PERL=C:\Perl64 DYNAMIC_PERL=yes PERL_VER=524 PYTHON=C:\Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=C:\Python35 DYNAMIC_PYTHON3=yes PYTHON3_VER=35  %1 IME=yes GIME=yes CSCOPE=yes USERNAME=nick USERDOMAIN=TSUKIHIME

IF EXIST vim.exe (
ECHO.
ECHO     [+] MAKE vim.exe SUCCESS!
ECHO.
) ELSE (
ECHO.
ECHO     [-] MAKE vim.exe FAILED! Please check makefile arguments.
ECHO.
)

:: vim: se ft=dosbash
:: EOF
