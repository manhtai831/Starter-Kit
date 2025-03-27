FROM node:21-alpine AS base

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

FROM node:21-alpine AS builder

WORKDIR /app

COPY --from=base /app/node_modules ./node_modules
COPY . .

RUN npm run build

FROM nginx:1.27-alpine AS runner
WORKDIR /app
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
