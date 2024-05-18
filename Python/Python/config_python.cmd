
SET "THISDRIVE=%~d0"
SET "THISPATH=%~dp0"
%THISDRIVE%
CD "%THISPATH%"

REM [Iterating and file parsing](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
FOR /F "delims=" %%L in ('DIR python* /A:D /B') DO (
  SET "FOLDER_PYTHOH=%%~fL"
  GOTO :DONE
)
:DONE

IF NOT "%FOLDER_PYTHOH%"=="" (
  ECHO FOLDER_PYTHOH=%FOLDER_PYTHOH%
) ELSE (
  ECHO FOLDER_PYTHOH not found
  EXIT 0
)

IF EXIST "%FOLDER_PYTHOH%\python.exe" (
  SET "PATH_CONFIG=PATH.txt"
  ECHO %FOLDER_PYTHOH% > "%PATH_CONFIG%"
) ELSE (
  ECHO python.exe not found
)



