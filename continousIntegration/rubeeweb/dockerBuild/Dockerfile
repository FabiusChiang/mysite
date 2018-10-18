FROM node:8.12.0-alpine

ADD app /app
RUN cd /app && npm install
WORKDIR /app

ENTRYPOINT [ "node", "start.js"]