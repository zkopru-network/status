FROM alpine:latest
MAINTAINER Chance Hudson

RUN apk add --no-cache nodejs npm

COPY . /src
WORKDIR /src

RUN npm i && npm run build

CMD ["npm", "run", "server"]
