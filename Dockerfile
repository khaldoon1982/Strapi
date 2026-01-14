FROM node:20-alpine AS build

RUN apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev vips-dev

WORKDIR /opt/app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

FROM node:20-alpine AS runtime

RUN apk add --no-cache vips-dev

WORKDIR /opt/app

ENV NODE_ENV=production
ENV NODE_OPTIONS="--dns-result-order=ipv4first"

COPY package.json package-lock.json ./
RUN npm ci --only=production

COPY --from=build /opt/app/config ./config
COPY --from=build /opt/app/src ./src
COPY --from=build /opt/app/public ./public
COPY --from=build /opt/app/database ./database
COPY --from=build /opt/app/build ./build
COPY --from=build /opt/app/favicon.png ./favicon.png

RUN addgroup -S strapi && adduser -S strapi -G strapi
RUN mkdir -p /opt/app/public/uploads && chown -R strapi:strapi /opt/app

USER strapi

EXPOSE 1337

CMD ["npm", "run", "start"]
