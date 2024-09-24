FROM node:22-alpine

RUN mkdir -p /opt/my-app
COPY app/* /opt/my-app
WORKDIR /opt/my-app

EXPOSE 3000

RUN npm install
CMD ["node", "server.js"]