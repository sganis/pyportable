:: build script to create a portable python for windows
:: version 	2.7.10rc1
:: author: 	sganis
:: date: 	05/16/2015

@echo off

:: update these values :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set PYTHON_URL=https://www.python.org/ftp/python/2.7.10/python-2.7.10rc1.amd64.msi
set PIP_URL=https://bootstrap.pypa.io/get-pip.py
set NUMPY_URL=http://www.lfd.uci.edu/~gohlke/pythonlibs/r7to5k3j/numpy-1.9.2+mkl-cp27-none-win_amd64.whl
set SCIPY_URL=http://www.lfd.uci.edu/~gohlke/pythonlibs/r7to5k3j/scipy-0.15.1-cp27-none-win_amd64.whl

:: this list of packages will be install using pip
::set PACKAGES=dateutils,ipython,pyreadline,sphinx,pillow,matplotlib,pandas
set PACKAGES=
:: no more update needed from here :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

echo Portable Python build script started... 

:: prepare folders
:: script directory without trailing backslash 
set DIR=%~dp0
IF %DIR:~-1%==\ SET DIR=%DIR:~0,-1%
set PORTABLE=%DIR%\PortablePython
set DOWNLOADS=%DIR%\Downloads
if not exist %PORTABLE%  mkdir %PORTABLE%
if not exist %DOWNLOADS% mkdir %DOWNLOADS%
	
:: python
call :download %PYTHON_URL%
echo filename: %filename%
echo Extracting python...
msiexec /quiet /a %DOWNLOADS%\%filename% TARGETDIR="%PORTABLE%"

:: new path
set PATH=%PORTABLE%;%PORTABLE%\Scripts;%PATH%

:: pip
call :download %PIP_URL%
python "%DOWNLOADS%\get-pip.py"

:: numpy
call :download %NUMPY_URL%
::pip install "%DOWNLOADS%\%filename%"

:: scipy
call :download %SCIPY_URL%
::pip install "%DOWNLOADS%\%filename%"

:: install list of packages
for %%i in (%PACKAGES%) do (
  pip install %%i
)

:: test
python %DIR%\test.py

::  installer
echo creating compressed package...
%DIR%\tools\7za.exe a PortablePython.exe -mmt -mx9 -sfx7z.sfx PortablePython >NUL

:: end
goto :eof


:: functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:download url
:: download file from url
:: extract filename from url and return filename
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SETLOCAL
FOR /f %%i IN ("%1") DO set filename=%%~nxi
set file=%DOWNLOADS%\%filename%
echo filename: %filename%
IF NOT EXIST %file% (
	echo downlowing %1...
	tools\wget.exe -U Mozilla/5.0 --progress=bar --no-check-certificate -N -P "%DOWNLOADS%" %1 ::2>NUL
) else (
	echo %file% exists, using cache version...
)
ENDLOCAL & SET filename=%filename%
goto :eof
::::::::::::::::::::::::::::::::::::::::::::
