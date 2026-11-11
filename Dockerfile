FROM node:26-bookworm-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        openssh-client \
        bash \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN npm install -g hexo-cli

# 預設啟動 Hexo
CMD ["bash", "/app/bash/restart.sh"]
