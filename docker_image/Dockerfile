FROM node:13.12.0 AS builder

RUN apt-get install -y git && \
    git clone https://github.com/shamahoque/mern-marketplace.git && \
    apt-get remove -y git
WORKDIR /mern-marketplace
RUN npm install --no-cache && \
    npm install --save-dev webpack --no-cache && \
    npm run build --no-cache


FROM node:13-alpine

WORKDIR /mern-marketplace
COPY --from=builder ./mern-marketplace/package.json ./
COPY --from=builder ./mern-marketplace/dist ./dist
COPY --from=builder ./mern-marketplace/node_modules ./node_modules

EXPOSE 3000

CMD ["node", "./dist/server.generated.js"]