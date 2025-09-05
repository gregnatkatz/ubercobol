@echo off
echo Starting COBOL UberEats Emulator Web Server...
echo.
echo The web server is starting up...
echo Your web browser should open automatically.
echo If it doesn't, go to: http://localhost:3000
echo.
echo To stop the server, close this window or press Ctrl+C
echo.

cd web-dist
start http://localhost:3000
python -m http.server 3000
