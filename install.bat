@echo off
echo ========================================
echo COBOL UberEats Emulator Installer
echo ========================================
echo.
echo This will install Node.js, build the app, and create a desktop shortcut.
echo Please wait while we set everything up...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js not found. Please install Node.js first from https://nodejs.org/
    echo After installing Node.js, run this script again.
    pause
    exit /b 1
)

echo Node.js found! Installing dependencies...
call npm install

echo.
echo Building the application...
call npm run build

echo.
echo Building web version...
call npm run build-web

echo.
echo Creating Windows executable...
call npx electron-builder --win --publish=never

echo.
echo Installation complete!
echo.
echo DESKTOP VERSION:
echo The executable has been created in the 'release' folder.
echo Look for: "COBOL UberEats Emulator - Patty's Food Tracker Setup.exe"
echo Double-click the Setup.exe file to install the application.
echo.
echo WEB VERSION:
echo The web files are in the 'web-dist' folder.
echo To serve locally, run: npm run serve-web
echo Then access: http://localhost:3000
echo.
echo Both versions are now ready to use!
echo.
pause
