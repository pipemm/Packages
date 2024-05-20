
SET "THISDRIVE=%~d0"
SET "THISPATH=%~dp0"
%THISDRIVE%
CD "%THISPATH%"

REM [Iterating and file parsing](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
FOR /F "delims=" %%L in ('DIR /B python-*.zip') DO (
  SET "FILE_ZIP=%%~fL"
  SET "FILE_NAME=%%~nL"
  GOTO :DONE
)
:DONE

SET "PYTHON_INSTALL=%FILE_NAME%\"
MKDIR "%PYTHON_INSTALL%"

tar -xvf "%FILE_ZIP%" -C %PYTHON_INSTALL%

IF ERRORLEVEL 1 (
  PowerShell.exe -Command "Expand-Archive -LiteralPath \"${env:FILE_ZIP}\" -Force;"
)

