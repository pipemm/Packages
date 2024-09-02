
where lilypond.exe
lilypond.exe --version

set "FOLDER_OUT=Output\"
mkdir %FOLDER_OUT%
set "FOLDER_CODE=Code\"
REM [set parameter](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for#remarks)
REM [enabledelayedexpansion](https://learn.microsoft.com/en-gb/windows-server/administration/windows-commands/setlocal#parameters)
setlocal enabledelayedexpansion
for %%F in (%FOLDER_CODE%*.ly) do (
  set "CODEFILE=%%F"
  echo Compiling !CODEFILE!
  lilypond.exe --output="%FOLDER_OUT%" --pdf --png "!CODEFILE!"
  where lilypond.exe
)
endlocal
where lilypond.exe
set "PATH=%PATH%"
where lilypond.exe
echo lilypond.exe --version
