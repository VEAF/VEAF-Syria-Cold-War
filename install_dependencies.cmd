@echo off
echo fetching the veaf-mission-creation-tools package
if exist yarn.lock (
	call yarn upgrade
) else (
	call yarn install
)

pause
