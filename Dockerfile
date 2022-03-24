FROM node:17-alpine

LABEL maintainer="Jamie <jamie@colournodes.com>"

COPY ./entrypoint.sh /entrypoint.sh

RUN apk add --update --no-cache git redis && \
    adduser -D -h /home/container container && \
    chmod +x /entrypoint.sh

USER container
ENV HOME=/home/container USER=container
WORKDIR /home/container

EXPOSE 3000

CMD ["/bin/sh","/entrypoint.sh"]