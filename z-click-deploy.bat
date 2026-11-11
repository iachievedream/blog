
@echo off
chcp 65001 > nul

cd /d "%~dp0"

echo ================================
echo       Hexo GitHub Pages Deploy
echo ================================

if not exist package.json (
    echo 錯誤：找不到 package.json，請先初始化 Hexo。
    pause
    exit /b 1
)

echo.
echo [1/2] 建置並啟動 Docker...
docker compose up -d --build
if errorlevel 1 goto error

echo.
echo [2/2] 執行 bash/deploy.sh...
docker compose exec hexo bash /app/bash/deploy.sh
if errorlevel 1 goto error

echo.
echo ================================
echo Hexo GitHub Pages 部署完成！
echo ================================
pause
exit /b 0

:error
echo.
echo ================================
echo 部署失敗！
echo 請檢查 Docker Desktop、SSH 權限及 Git 設定。
echo ================================
pause
exit /b 1
