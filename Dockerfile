# 使用 nginx 作為前端伺服器
FROM node:20-bullseye AS builder

# 設定工作目錄
WORKDIR /app

# 複製 package.json 和 package-lock.json
COPY package.json package-lock.json ./

# 安裝前端相依套件
RUN npm install

# 複製所有專案檔案
COPY . .

# 建立前端專案
RUN npm run build

# 使用 Nginx 作為靜態檔案伺服器
FROM nginx:alpine

# 移除預設的 Nginx 設定
RUN rm -rf /usr/share/nginx/html/*

# 複製編譯後的前端檔案到 Nginx 目錄
COPY --from=builder /app/dist /usr/share/nginx/html

# 開放 80 port
EXPOSE 80

# 啟動 Nginx
CMD ["nginx", "-g", "daemon off;"]
