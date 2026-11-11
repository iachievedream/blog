#!/usr/bin/env bash

set -e

# 切換至 Hexo 專案根目錄
cd "$(dirname "$0")/.."

if [ ! -f package.json ]; then
    echo "錯誤：找不到 package.json，請先初始化 Hexo。"
    exit 1
fi

echo "================================"
echo "       Hexo GitHub Pages Deploy"
echo "================================"

# 設定 Git 身分（可依需求修改）
git config --global user.name "hexo-deploy-bash"
git config --global user.email "hexo-deploy-bash@bash.com"

echo ""
echo "[1/3] Hexo Clean..."
npx hexo clean

echo ""
echo "[2/3] Hexo Generate..."
npx hexo generate

echo ""
echo "[3/3] Hexo Deploy..."
npx hexo deploy

echo ""
echo "================================"
echo " Hexo GitHub Pages 部署完成！"
echo "================================"
