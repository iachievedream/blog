#!/bin/bash

cd "$(dirname "$0")"

echo "================================"
echo "       Hexo Docker 啟動中"
echo "================================"

# 確認 Docker 專案
if [ ! -f package.json ]; then
    echo "錯誤：找不到 package.json"
    read -p "按 Enter 鍵結束..."
    exit 1
fi

# 確認 Docker Desktop
if ! docker info >/dev/null 2>&1; then
    echo "錯誤：請先啟動 Docker Desktop。"
    read -p "按 Enter 鍵結束..."
    exit 1
fi

docker compose down
echo ""
echo "[1/3] 建置並啟動 Docker..."

if ! docker compose up -d --build; then
    echo "Docker 啟動失敗！"
    docker compose logs --tail=50 hexo
    read -p "按 Enter 鍵結束..."
    exit 1
fi

echo ""
echo "[2/3] 等待 Hexo Server 啟動..."

# 最多等待 60 秒
READY=0

for i in {1..30}; do
    if curl -fsS http://localhost:4000/ >/dev/null 2>&1; then
        READY=1
        break
    fi
    sleep 2
done

echo ""

if [ "$READY" -eq 1 ]; then
    echo "================================"
    echo "[3/3] Hexo Server 啟動成功！"
    echo "網址：http://localhost:4000"
    echo "================================"
    open http://localhost:4000
else
    echo "================================"
    echo "Hexo Server 啟動失敗或逾時！"
    echo "================================"
    echo ""
    echo "Docker 容器狀態："
    docker compose ps
    echo ""
    echo "Hexo 錯誤日誌："
    docker compose logs --tail=100 hexo
fi

echo ""
read -p "按 Enter 鍵結束..."
