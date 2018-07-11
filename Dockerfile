FROM node:6-alpine

RUN apk add --update git

COPY . /home/instant-search-demo

WORKDIR /home/instant-search-demo

RUN npm install

EXPOSE 3000

CMD ["npm", "start"]
