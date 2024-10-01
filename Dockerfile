FROM node:22-alpine

RUN mkdir -p /opt/
COPY ./app /opt/
WORKDIR /opt/app/

EXPOSE 3000

RUN npm install
CMD ["node", "server.js"]
