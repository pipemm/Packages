
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

ECHO /?

REM /?

CD /?

WHERE /?

MKDIR /?

DIR /?

DIR /S

TYPE /?

IF /?

GOTO /?

EXIT /?

REM [a drive letter and path only](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
SET "THISPATH=%~dp0"
ECHO THISPATH=%THISPATH%
ECHO cd=%cd%


