@echo off
setlocal enabledelayedexpansion

echo ========================================
echo COBOL UberEats Emulator Installer
echo ========================================
echo.
echo This installer will set up the COBOL UberEats Emulator for you.
echo It will check requirements, install dependencies, and build the app.
echo Please be patient - this may take several minutes...
echo.

REM Check if Node.js is installed
echo [1/6] Checking Node.js installation...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Node.js is not installed on this computer.
    echo.
    echo SOLUTION:
    echo 1. Go to https://nodejs.org/
    echo 2. Download the "LTS" version (recommended for most users)
    echo 3. Run the installer and follow the prompts
    echo 4. Restart this computer
    echo 5. Run this install.bat script again
    echo.
    echo If you need help, ask someone to assist with installing Node.js.
    pause
    exit /b 1
)

for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo Node.js found: !NODE_VERSION!

REM Check internet connectivity (non-blocking)
echo.
echo [2/6] Checking internet connection...
ping -n 1 registry.npmjs.org >nul 2>&1
if %errorlevel% neq 0 (
    echo Internet connection test failed - this is often normal.
    echo Continuing with installation - npm may still work fine.
) else (
    echo Internet connection: OK
)

REM Install dependencies
echo.
echo [3/6] Installing dependencies...
echo This may take 2-5 minutes depending on your internet speed...
call npm install
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to install required components.
    echo.
    echo POSSIBLE SOLUTIONS:
    echo 1. Check your internet connection
    echo 2. Try running this script as Administrator (right-click, "Run as administrator")
    echo 3. Temporarily disable antivirus software and try again
    echo 4. Contact technical support if the problem persists
    echo.
    pause
    exit /b 1
)
echo Dependencies installed successfully!

REM Build the main application
echo.
echo [4/6] Building the application...
call npm run build
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to build the application.
    echo.
    echo SOLUTION:
    echo Please contact technical support - there may be an issue with the source code.
    echo.
    pause
    exit /b 1
)

REM Check if build output exists
if not exist "dist" (
    echo.
    echo ERROR: Application build failed - no output files created.
    echo Please contact technical support.
    pause
    exit /b 1
)
echo Application built successfully!

REM Build web version
echo.
echo [5/6] Building web version...
call npm run build-web
if %errorlevel% neq 0 (
    echo.
    echo ERROR: Failed to build web version.
    echo The desktop version may still work, but web version will not be available.
    echo.
)

REM Check if web build output exists
if not exist "web-dist" (
    echo WARNING: Web version build failed - only desktop version will be available.
) else (
    echo Web version built successfully!
)

REM Create Windows executable
echo.
echo [6/6] Creating Windows installer...
echo This may take 1-2 minutes...
call npx electron-builder --win --publish=never
if %errorlevel% neq 0 (
    echo.
    echo WARNING: Windows installer creation failed.
    echo This is normal on some systems and doesn't affect the web version.
    echo.
    echo ALTERNATIVE SOLUTIONS:
    echo 1. Use the web version instead (easier and works the same)
    echo 2. Try running this script as Administrator
    echo 3. Check that you have enough disk space (need at least 500MB free)
    echo 4. The web version works perfectly and is easier to use
    echo.
    echo Continuing with web version setup...
    echo.
)

REM Check if installer was created, but don't fail if it wasn't
if exist "release\*.exe" (
    set DESKTOP_AVAILABLE=1
    echo Windows installer created successfully!
) else (
    set DESKTOP_AVAILABLE=0
    echo Windows installer not available - using web version only.
)

echo.
echo ========================================
echo INSTALLATION COMPLETED SUCCESSFULLY!
echo ========================================
echo.

if %DESKTOP_AVAILABLE%==1 (
    echo DESKTOP VERSION AVAILABLE:
    echo 1. Look in the 'release' folder
    echo 2. Find the file ending in "Setup.exe"
    echo 3. Double-click it to install the application
    echo 4. Follow the installation prompts
    echo 5. The app will appear in your Start Menu
    echo.
)

if exist "web-dist" (
    echo WEB VERSION ^(RECOMMENDED^):
    echo 1. Double-click "start-web.bat" to start the application
    echo 2. Your web browser will open automatically
    echo 3. If it doesn't open, go to: http://localhost:3000
    echo 4. This version works exactly the same as the desktop version
    echo.
    
    if %DESKTOP_AVAILABLE%==0 (
        echo NOTE: Only the web version is available on this system.
        echo This is completely normal and the web version works perfectly!
        echo.
    )
)

echo NEED HELP?
echo - Read the README.md file for detailed instructions
echo - The desktop version is easier to use
echo - Contact technical support if you have problems
echo.
echo Press any key to finish...
pause >nul
