:: build script to create a portable python for windows
:: author: 	sganis
:: date: 	05/16/2015

@ECHO OFF

:: update these values :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SET VERSION=2.7.10rc1
SET PYTHON_URL=https://www.python.org/ftp/python/2.7.10/python-%VERSION%.amd64.msi
SET PIP_URL=https://bootstrap.pypa.io/get-pip.py

:: wheels from UCI
SET UCI=http://www.lfd.uci.edu/~gohlke/pythonlibs/r7to5k3j
SET NUMPY_URL=%UCI%/numpy-1.9.2+mkl-cp27-none-win_amd64.whl
SET SCIPY_URL=%UCI%/scipy-0.15.1-cp27-none-win_amd64.whl

:: this list of packages will be install using pip from PyPi
SET PACKAGES=dateutils,ipython,pyreadline,sphinx,pillow,matplotlib,pandas
:: no more update needed from here :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

ECHO Building... 

:: script directory without trailing backslash 
SET DIR=%~dp0
IF %DIR:~-1%==\ SET DIR=%DIR:~0,-1%

SET PYPORTABLE=%DIR%\Pyportable-%VERSION%
SET DOWNLOADS=%DIR%\Downloads
IF NOT EXIST %PYPORTABLE%  MKDIR %PYPORTABLE%
IF NOT EXIST %DOWNLOADS% MKDIR %DOWNLOADS%
	
:: python
CALL :download %PYTHON_URL%
SET PYTHON_MSI=%filename%
ECHO Extracting python...
msiexec /quiet /a %DOWNLOADS%\%PYTHON_MSI% TARGETDIR="%PYPORTABLE%"

:: new path
SET PATH=%PYPORTABLE%;%PYPORTABLE%\Scripts;%PATH%

:: pip
CALL :download %PIP_URL%
python "%DOWNLOADS%\get-pip.py"
:: make it portable
python patchpip.py %PYPORTABLE%

:: first numpy to install Intel Libs
CALL :download %NUMPY_URL%
pip install "%DOWNLOADS%\%filename%"

:: loop over list of packages, install with pip
::FOR %%i in (%PACKAGES%) do pip install %%i

:: some packages needs a pre-build wheel: scipy
::call :download %SCIPY_URL%
::pip install "%DOWNLOADS%\%filename%"

:: cleanup
rmdir /s /q %PYPORTABLE%\Doc
del %PYPORTABLE%\%PYTHON_MSI%
del %PYPORTABLE%\NEWS.txt
del %PYPORTABLE%\README.txt

:: test
python %DIR%\test.py

::  package
COPY %DIR%\terminal.bat %PYPORTABLE%
copy %DIR%\README.rst %PYPORTABLE%
copy %DIR%\LICENSE.txt %PYPORTABLE%

ECHO creating compressed package...
::%DIR%\tools\7za.exe a Pyportable.exe -mmt -mx9 -sfx7z.sfx %PYPORTABLE% >NUL
%DIR%\tools\7za.exe a pyportable-%VERSION%.zip -tzip -mmt -mx9 %PYPORTABLE% >NUL

:: end
GOTO :eof


:: functions
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:download url
:: download file from url
:: extract filename from url and return filename
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SETLOCAL
FOR /f %%i IN ("%1") DO SET filename=%%~nxi
SET file=%DOWNLOADS%\%filename%
ECHO filename: %filename%
IF NOT EXIST %file% (
	ECHO downlowing %1...
	tools\wget.exe -U Mozilla/5.0 --progress=bar --no-check-certificate -N -P "%DOWNLOADS%" %1 ::2>NUL
) ELSE (
	ECHO %file% exists, using cache version...
)
ENDLOCAL & SET filename=%filename%
GOTO :eof
::::::::::::::::::::::::::::::::::::::::::::
