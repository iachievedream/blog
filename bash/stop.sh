#!/usr/bin/env bash

set -e

cd "$(dirname "$0")/.."

docker compose down

echo "Hexo Docker 環境已停止。"
