
REM [Directories Only](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for#remarks)
FOR /D %%D in (Package\lilypond-*\bin\) DO (
  SET "subfolder=%%D"
  GOTO :found
)
:found

ECHO %subfolder%
ECHO %PATH%
