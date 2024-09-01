
REM [Directories Only](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for#remarks)
FOR /D %%F in (Package\lilypond-*) DO (
  SET "subfolder=%%F"
  GOTO :found
)
:found

SET "PATH_LILYPOND=%CD%\%subfolder%\bin"
IF "%PATH_LILYPOND%"=="" (
  EXIT 1
)
SET "PATH=%PATH%;%PATH_LILYPOND%"

ECHO %PATH%

IF "%GITHUB_ENV%"=="" (
  EXIT 0
)
ECHO PATH_LILYPOND=%PATH_LILYPOND%
ECHO PATH_LILYPOND=%PATH_LILYPOND% >> %GITHUB_ENV%
ECHO PATH=%PATH%
ECHO PATH=%PATH%                   >> %GITHUB_ENV%
