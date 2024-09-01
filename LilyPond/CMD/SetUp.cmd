
REM [Directories Only](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for#remarks)
FOR /D %%F in (Package\lilypond-*) DO (
  SET "subfolder=%%F"
  GOTO :found
)
:found

ECHO %subfolder%
ECHO %PATH%

IF "%subfolder%"=="" (
  EXIT 1
)

SET "PATH_LILYPOND=%CD%\%subfolder%\bin"
SET "PATH=%PATH%;%PATH_LILYPOND%"
