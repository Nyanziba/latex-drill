@echo off
setlocal

py -3 "%~dp0drill" %*
if errorlevel 9009 python "%~dp0drill" %*
exit /b %errorlevel%
