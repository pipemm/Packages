
SET "THISDRIVE=%~d0"
SET "THISPATH=%~dp0"
%THISDRIVE%
CD "%THISPATH%"

SET "PYTHON_CONFIG=Python\PATH.txt"
SET /P PATH_PYTHON= < "%PYTHON_CONFIG%"
IF NOT EXIST "%PATH_PYTHON%\python.exe" (
    ECHO python.exe not found
    EXIT /B 1
)
SET "PATH=%PATH_PYTHON%;%PATH%"

SET "FOLDER_CSV=CSV\"

python.exe --version
