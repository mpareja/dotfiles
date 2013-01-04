@echo off
set HOME=%userprofile%

rem make file path relative to dir
set dir=%CD%
set git=%~1
shift
set file=%~1
shift
call set file=%%file:%dir%\=%%

rem TODO: paths is case senstive, need to fix

rem Annoyingly, shift does not affect % * so must list all out
echo %CD%
echo %git% %1 %2 %3 %4 %5 %6 %7 %8 %9 -- "%file%"
start /B %git% %1 %2 %3 %4 %5 %6 %7 %8 %9 -- "%file%"
echo done.
