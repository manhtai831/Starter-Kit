FROM node:23-alpine3.20 AS base

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

FROM node:23-alpine3.20 AS builder

WORKDIR /app

COPY --from=base /app/node_modules ./node_modules
COPY . .

RUN yarn build

FROM nginx:1.27-alpine AS runner
WORKDIR /app
COPY --from=builder /app/dist /usr/share/nginx/html
COPY --from=builder /app/dist /app/dist

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
