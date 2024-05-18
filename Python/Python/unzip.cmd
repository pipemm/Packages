
SET "THISPATH=%~dp0"
CD "%THISPATH%"

REM [Iterating and file parsing](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
FOR /F "delims=" %%L in ('DIR /B *.zip') DO (
  SET "FILE_ZIP=%%~fL"
  SET "FILE_NAME=%%~nL"
  GOTO :DONE
)
:DONE

ECHO %FILE_ZIP%
SET "PYTHON_INSTALL=%FILE_NAME%\\"
MKDIR "%PYTHON_INSTALL%"

tar -xf "%FFILE_ZIP%" -C "%PYTHON_INSTALL%"

