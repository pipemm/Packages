
where lilypond.exe

set "FOLDER_OUT=Output\"
mkdir %FOLDER_OUT%
set "FOLDER_CODE=Code\"
REM [set parameter](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for#remarks)

setlocal enabledelayedexpansion
for %%F in (%FOLDER_CODE%*.ly) do (
  set "CODEFILE=%%F"
  echo !CODEFILE!
  echo %CODEFILE%
  echo lilypond.exe --output="%FOLDER_OUT%" --pdf --png "!CODEFILE!"
)
endlocal

