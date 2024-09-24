FROM node:22-alpine

RUN mkdir -p /opt/app
COPY app/* /opt/app
WORKDIR /opt/app

EXPOSE 3000

RUN npm install
CMD ["node", "server.js"]