@echo off

echo %1

cd /d %~dp0

echo %CD%

if exist %1 goto EXECUTE else goto USAGE

:EXECUTE
REM IF bin file remove all zenkaku space, use below
rem ruby ld_aggregation.rb %1 ""
ruby ld_aggregation.rb %1 "CP932"

goto EXIT

:USAGE
echo "Drag and Drop LD aggregation bin data on this batch file"

:EXIT
pause
