FROM node:21-alpine AS base

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

FROM node:21-alpine  AS builder

WORKDIR /app

COPY --from=base /app/node_modules ./node_modules
COPY . .

RUN yarn build \
    && yarn install --production --frozen-lockfile \
    && rm -rf .next/cache

FROM node:21-alpine AS runner

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/next.config.ts ./
COPY --from=builder /app/package.json ./

EXPOSE 3000

ENV NODE_ENV=production

CMD ["yarn", "start"]
