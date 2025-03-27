FROM node:21-alpine AS base

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci

FROM node:21-alpine  AS builder

WORKDIR /app

COPY --from=base /app/node_modules ./node_modules
COPY . .

RUN npm run build \
    && npm prune --production

FROM node:21-alpine AS runner

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package.json ./

EXPOSE 3000

ENV NODE_ENV=production

CMD [ "npm", "run", "start:prod" ]
