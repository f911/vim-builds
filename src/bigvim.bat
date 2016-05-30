:: command to build big Vim with OLE, Perl, Python, Ruby and Tcl
SET VCDIR="C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin\amd64"

%VCDIR%nmake -f Make_mvc.mak SDK_INCLUDE_DIR="C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include" FEATURES=HUGE GUI=yes OLE=yes DIRECTX=yes PERL=C:\Perl64 DYNAMIC_PERL=yes PERL_VER=522 PYTHON=C:\Python27 DYNAMIC_PYTHON=yes PYTHON_VER=27 PYTHON3=C:\Python34 DYNAMIC_PYTHON3=yes PYTHON3_VER=34 %1 IME=yes GIME=yes CSCOPE=yes USERNAME=nick USERDOMAIN=TSUHIKIME

