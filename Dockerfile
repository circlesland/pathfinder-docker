FROM alpine AS build
RUN apk add git build-base cmake nodejs npm

MAINTAINER chriseth <chris@ethereum.org>
LABEL org.opencontainers.image.source=https://github.com/circlesland/pathfinder-docker

WORKDIR /usr/o-platform/
RUN git clone https://github.com/circlesland/pathfinder.git
WORKDIR /usr/o-platform/pathfinder
COPY ./package.json /usr/o-platform/pathfinder
RUN mkdir build
WORKDIR /usr/o-platform/pathfinder/build
RUN cmake .. -DCMAKE_BUILD_TYPE=Release
RUN make
WORKDIR /usr/o-platform/pathfinder
RUN npm install
ENTRYPOINT ["node", "./index.js",  "8080"]