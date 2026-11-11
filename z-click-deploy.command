#!/bin/bash

cd "$(dirname "$0")"

echo "================================"
echo "       Hexo GitHub Pages Deploy"
echo "================================"

# 確認 Hexo 專案
if [ ! -f package.json ]; then
    echo "錯誤：找不到 package.json，請確認目前目錄是 Hexo 專案根目錄。"
    read -p "按 Enter 鍵結束..."
    exit 1
fi

docker compose down
echo ""
echo "[1/2] 建置並啟動 Docker..."

docker compose up -d --build
if [ $? -ne 0 ]; then
    echo "Docker 啟動失敗，請確認 Docker Desktop 已啟動。"
    read -p "按 Enter 鍵結束..."
    exit 1
fi

echo ""
echo "[2/2] 執行 Hexo 部署..."
docker compose exec hexo bash /app/bash/deploy.sh

if [ $? -ne 0 ]; then
    echo ""
    echo "================================"
    echo "部署失敗！"
    echo "請檢查 Docker、SSH 權限及 Git 設定。"
    echo "================================"
    read -p "按 Enter 鍵結束..."
    exit 1
fi

echo ""
echo "================================"
echo "Hexo GitHub Pages 部署完成！"
echo "================================"
read -p "按 Enter 鍵結束..."
