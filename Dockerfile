# FROM node:latest
FROM node:14.4.0-alpine3.12

RUN mkdir -p /var/www/app

WORKDIR /var/www/app

COPY package*.json ./

RUN npm install && npm cache clean --force

ENV PATH=/var/www/app/node_modules/.bin:$PATH

RUN mkdir -p /var/www/app/src

WORKDIR /var/www/app/src

ONBUILD RUN /var/www/app/node_modules/.bin/mocha /var/www/app/src/test/*.test.js

COPY src .

EXPOSE 3000