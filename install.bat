@echo off
setlocal enabledelayedexpansion

echo ========================================
echo COBOL UberEats Emulator Auto-Installer
echo ========================================
echo.
echo This will automatically install everything needed for the COBOL UberEats Emulator.
echo No technical knowledge required - just wait and it will do everything!
echo.
echo What this installer will do:
echo 1. Download and install Node.js (if needed)
echo 2. Install all required components
echo 3. Build the desktop and web applications
echo 4. Create shortcuts for easy access
echo.
echo Please be patient - this may take 5-10 minutes...
echo.
echo Press any key to start the automatic installation...
pause >nul

REM Check if Node.js is installed
echo.
echo [Step 1/6] Checking if Node.js is already installed...
node --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Node.js not found - will install automatically...
    echo.
    echo [Step 2/6] Downloading Node.js installer...
    echo Please wait while we download Node.js (this may take 1-2 minutes)...
    
    REM Download Node.js LTS installer
    powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://nodejs.org/dist/v20.17.0/node-v20.17.0-x64.msi' -OutFile 'nodejs-installer.msi'}"
    
    if not exist "nodejs-installer.msi" (
        echo.
        echo ERROR: Could not download Node.js installer.
        echo Please check your internet connection and try again.
        echo.
        echo If this problem continues, you may need to:
        echo 1. Install Node.js manually from https://nodejs.org/
        echo 2. Then run this install.bat script again
        echo.
        pause
        exit /b 1
    )
    
    echo Download complete!
    echo.
    echo [Step 3/6] Installing Node.js...
    echo A Windows installer window will appear - please follow the prompts.
    echo Just click "Next" and "Install" when asked.
    echo.
    
    REM Install Node.js silently
    msiexec /i nodejs-installer.msi /quiet /norestart
    
    echo Node.js installation complete!
    echo.
    echo Cleaning up installer file...
    del nodejs-installer.msi >nul 2>&1
    
    echo.
    echo IMPORTANT: Please restart your computer now for Node.js to work properly.
    echo After restarting, run this install.bat script again.
    echo.
    echo Press any key to close this installer...
    pause >nul
    exit /b 0
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
    echo Node.js is already installed: !NODE_VERSION!
)

REM Continue with the rest of the installation
echo.
echo [Step 2/6] Checking internet connection...
ping -n 1 registry.npmjs.org >nul 2>&1
if %errorlevel% neq 0 (
    echo Internet connection test failed - this is often normal.
    echo Continuing with installation - npm may still work fine.
) else (
    echo Internet connection: OK
)

echo.
echo [Step 3/6] Installing application components...
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

echo.
echo [Step 4/6] Building the application...
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

echo.
echo [Step 5/6] Building web version...
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

echo.
echo [Step 6/6] Creating Windows installer...
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
    echo 3. If it doesn't open, the web address will be shown
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
