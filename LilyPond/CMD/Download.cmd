
if "%URL_PACKAGE%"=="" (
  EXIT /B 1
)

REM [Variable Substitution](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
for %%I in ("%URL_PACKAGE%") do (
  set "FILE_PACKAGE=%%~nxI"
  set "NAME_PACKAGE=%%~nI"
)
echo %FILE_PACKAGE%
echo %NAME_PACKAGE%

set "FOLDER_PACK=Package\"
set "FOLDER_DL=%FOLDER_PACK%\Download\"
if not exist "%FOLDER_DL%" (
  MKDIR "%FOLDER_DL%"
)

set FILE_PACKAGE=%FOLDER_DL%%FILE_PACKAGE%
curl --output "%FILE_PACKAGE%" --location "%URL_PACKAGE%"

unzip -l "%FILE_PACKAGE%" | findstr /n /r "^" | findstr "^4:"

for /f "tokens=4" %%A in ('unzip -l "%FILE_PACKAGE%" ^| findstr /n /r "^" ^| findstr "^4:"') do (
  set "ZIP_FOLDER=%%A"
)

echo %ZIP_FOLDER%


