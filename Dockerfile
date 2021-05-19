FROM node:13-slim

COPY ./app /app

WORKDIR /app

RUN npm install

RUN nodejs seeds/seed.js


EXPOSE 3000

CMD ["nodejs", "app.js"]

