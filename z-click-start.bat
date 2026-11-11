
@echo off
chcp 65001 > nul

cd /d "%~dp0"

echo ================================
echo       Hexo Docker 啟動中
echo ================================

if not exist package.json (
    echo 錯誤：找不到 package.json，請先初始化 Hexo。
    pause
    exit /b 1
)

echo.
echo 執行 bash/restart.sh...

docker compose up -d --build
if errorlevel 1 goto error

docker compose exec hexo bash /app/bash/restart.sh
if errorlevel 1 goto error

echo.
echo ================================
echo Hexo Server 已啟動
echo http://localhost:4000
echo ================================
pause
exit /b 0

:error
echo.
echo ================================
echo 啟動失敗！
echo 請確認 Docker Desktop 已啟動。
echo ================================
pause
exit /b 1
