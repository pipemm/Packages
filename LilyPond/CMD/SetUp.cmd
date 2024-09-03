
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

REM [TIMEOUT alternative](https://www.ibm.com/support/pages/timeout-command-run-batch-job-exits-immediately-and-returns-error-input-redirection-not-supported-exiting-process-immediately)
ping -n 3 127.0.0.1 >NUL
REM The program inspects Scheme source code files (.scm) and their corresponding compiled files (.go). 
REM If a source code file has a more recent timestamp than its compiled counterpart, a warning message is shown. 
REM This issue appears to be linked to the GUILE_AUTO_COMPILE=1 setting.
REM The program might then attempt to recompile the source code, which is likely to result in a fatal error, possibly because the current environment is not configured for compiling.
REM [assign the current time and date to a file without modifying the file](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/copy)
REM [enabledelayedexpansion](https://learn.microsoft.com/en-gb/windows-server/administration/windows-commands/setlocal#parameters)
setlocal enabledelayedexpansion
for /f %%F in ('DIR /S /B %subfolder%\lib\*.go') do (
  set "gofile=%%F"
  ECHO !gofile!
  COPY /B !gofile! +,,
)
endlocal

lilypond.exe --version
lilypond.exe --help

IF "%GITHUB_ENV%"=="" (
  EXIT /B 0
)
ECHO PATH_LILYPOND=%PATH_LILYPOND%
ECHO PATH_LILYPOND=%PATH_LILYPOND%>> %GITHUB_ENV%
ECHO PATH=%PATH%
ECHO PATH=%PATH%>> %GITHUB_ENV%
