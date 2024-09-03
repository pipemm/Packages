
REM [Directories Only](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for#remarks)
for /D %%F in (Package\lilypond-*) do (
  set "subfolder=%%F"
  goto :found
)
:found

set "PATH_LILYPOND=%CD%\%subfolder%\bin"
if "%PATH_LILYPOND%"=="" (
  EXIT /B 1
)
set "PATH=%PATH%;%PATH_LILYPOND%"

where lilypond.exe
if %ERRORLEVEL% neq 0 (
  EXIT /B 1
)

lilypond.exe --version
lilypond.exe --help

IF "%GITHUB_ENV%"=="" (
  EXIT /B 0
)
ECHO PATH_LILYPOND=%PATH_LILYPOND%
ECHO PATH_LILYPOND=%PATH_LILYPOND%>> %GITHUB_ENV%
ECHO PATH=%PATH%
ECHO PATH=%PATH%>> %GITHUB_ENV%
