
SET "PYTHON_CONFIG=Python\PATH.txt"
SET /P PATH_PYTHON= < "%PYTHON_CONFIG%"
IF EXIST "%PATH_PYTHON%\python.exe" (
  ECHO %PATH%
  TYPE %GITHUB_ENV%
) ELSE (
  ECHO python.exe not found
  EXIT /B 1
)