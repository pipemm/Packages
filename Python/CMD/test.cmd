
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

CD /?

WHERE /?

MKDIR /?

DIR /?

DIR /S

GOTO /?

REM [a drive letter and path only](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/for)
SET "THISPATH=%~dp0"
ECHO THISPATH=%THISPATH%
ECHO cd=%cd%


