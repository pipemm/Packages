
if "%URL_PACKAGE%"=="" (
    EXIT /B 1
)

for %%F in ("%URL_PACKAGE%") do (
    set "FILE_PACKAGE=%%~nxF"
)
echo %FILE_PACKAGE%
