
REM [set parameter](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for#remarks)
FOR %%F IN (Code\*.ly) DO (
  SET "CODEFILE=%%F"
  ECHO "%CODEFILE%"
)
