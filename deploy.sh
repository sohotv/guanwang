#!/bin/bash
# 本地构建
npm run build  # 如果是前端项目需要构建

# 同步到远程服务器
rsync -avz --delete ./dist/ user@your-server-ip:/var/www/html/website/ 