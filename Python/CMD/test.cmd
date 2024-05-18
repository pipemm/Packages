
WHERE /T curl

curl --version

WHERE /T python

python --version

WHERE /T python3

python3 --version

WHERE /T tar

tar /?
tar --help

ECHO PATH=%PATH%

WHERE /?

REM DIR /?

ECHO errorlevel=%errorlevel%

DIR /S

ECHO errorlevel=%errorlevel%

REM [%~dpI](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
SET "THISPATH=%~dp0"
ECHO THISPATH=%THISPATH%

ECHO errorlevel=%errorlevel%
