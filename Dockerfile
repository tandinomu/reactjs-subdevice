FROM node:alpine AS builder

WORKDIR /app

COPY package.json ./
RUN npm install --legacy-peer-deps

COPY ./ ./

# 👇 Add this line to fix the crypto issue
ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
