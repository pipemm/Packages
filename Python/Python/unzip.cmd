
SET "THISPATH=%~dp0"
SET "THISDRIVE=%~d0"
%THISDRIVE%
CD "%THISPATH%"

REM [Iterating and file parsing](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
FOR /F "delims=" %%L in ('DIR /B *.zip') DO (
  SET "FILE_ZIP=%%~fL"
  SET "FILE_NAME=%%~nL"
  GOTO :DONE
)
:DONE

ECHO %FILE_ZIP%
SET "PYTHON_INSTALL=%FILE_NAME%\"
ECHO PYTHON_INSTALL=%PYTHON_INSTALL%
MKDIR "%PYTHON_INSTALL%"

tar -xvf "%FILE_ZIP%" -C %PYTHON_INSTALL%

