
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

