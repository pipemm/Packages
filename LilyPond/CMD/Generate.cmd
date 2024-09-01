
where lilypond

set "FOLDER_OUT=Output\"
mkdir %FOLDER_OUT%
set "FOLDER_CODE=Code\"
REM [set parameter](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for#remarks)
for %%F in (%FOLDER_CODE%*.ly) do (
  set "CODEFILE=%%F"
  ECHO %CODEFILE%
)
