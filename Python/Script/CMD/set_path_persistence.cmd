
SET "PYTHON_CONFIG=Python\PATH.txt"
SET /P PATH_PYTHON= < "%PYTHON_CONFIG%"
IF NOT EXIST "%PATH_PYTHON%\python.exe" (
  ECHO python.exe not found
  EXIT /B 1
)

ECHO %PATH%
TYPE %GITHUB_ENV%