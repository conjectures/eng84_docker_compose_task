FROM node:13-slim

COPY ./app /app

WORKDIR /app

RUN npm install

EXPOSE 3000

CMD ["node", "app.js"]

