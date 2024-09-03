
if "%URL_PACKAGE%"=="" (
  EXIT /B 1
)

REM [Variable Substitution](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
for %%I in ("%URL_PACKAGE%") do (
  set "FILE_PACKAGE=%%~nxI"
  set "NAME_PACKAGE=%%~nI"
)

set "FOLDER_PACK_0=Package"
set "FOLDER_DL=%FOLDER_PACK_0%\Download\"
if not exist "%FOLDER_DL%" (
  MKDIR "%FOLDER_DL%"
)

set FILE_PACKAGE=%FOLDER_DL%%FILE_PACKAGE%
curl --output "%FILE_PACKAGE%" --location "%URL_PACKAGE%"

for /f "tokens=5" %%A in ('unzip -l "%FILE_PACKAGE%" ^| findstr /n /r "^" ^| findstr "^4:"') do (
  set "ZIP_FOLDER=%%A"
)

unzip "%FILE_PACKAGE%" -d %FOLDER_PACK_0%

set "FOLDER_ARTIFACT=%FOLDER_PACK_0%\%ZIP_FOLDER:/=\%"
if  exist "%FOLDER_ARTIFACT%" (
  set "FOLDER_ARTIFACT=%CD%\%FOLDER_ARTIFACT%"
) else (
  EXIT /B 1
)

IF "%GITHUB_ENV%"=="" (
  EXIT /B 0
)
ECHO FOLDER_ARTIFACT=%FOLDER_ARTIFACT%
ECHO FOLDER_ARTIFACT=%FOLDER_ARTIFACT%>> %GITHUB_ENV%
ECHO NAME_PACKAGE=%NAME_PACKAGE%
ECHO NAME_PACKAGE=%NAME_PACKAGE%>> %GITHUB_ENV%
