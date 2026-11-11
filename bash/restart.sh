#!/usr/bin/env bash

set -e

# 切換至 Hexo 專案根目錄
cd "$(dirname "$0")/.."

echo "================================"
echo "       Hexo Server 啟動中"
echo "================================"

# 確認 Hexo 專案
if [ ! -f package.json ]; then
    echo "錯誤：找不到 package.json"
    exit 1
fi

# 安裝 Hexo 專案依賴
echo "[1/2] 安裝 npm dependencies..."

npm install

# 啟動 Hexo Server
echo "[2/2] 啟動 Hexo Server..."

exec npx hexo server -i 0.0.0.0 -p 4000
