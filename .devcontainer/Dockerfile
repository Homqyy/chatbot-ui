FROM node:19-alpine

RUN apk add git proxychains-ng

WORKDIR /usr/src/chatgpt-ui

COPY ./chatgpt-ui/package*.json ./ 

RUN npm ci
