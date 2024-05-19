
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

SET "FOLDER_CSV1=%FOLDER_CSV%Column\"
MKDIR "%FOLDER_CSV1%"
SET "FILE_CSV1=%FOLDER_CSV1%test_column.csv"

SET "FOLDER_PY=Script\Python\"

SET "PY_CSV_EXCEL_COL=%FOLDER_PY%excel_column.py"

python.exe "%PY_CSV_EXCEL_COL%" > "%FILE_CSV1%"

TYPE "%FILE_CSV1%"