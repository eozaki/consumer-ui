FROM node:23-alpine3.19 AS base

FROM base AS unit-tests

RUN addgroup -S deco
RUN adduser -g docker -G deco -h /home/deco deco -D

RUN apk add --update make g++ bash zsh git openssh postgresql-dev nodejs yarn sudo nano python3 libstdc++ libx11 libxrender libxext libssl3 ca-certificates fontconfig freetype ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-freefont
RUN apk add --update libssl3 shared-mime-info

ENV APP_PATH "/home/deco/consumer-ui"

USER root

RUN mkdir -p $APP_PATH

RUN chown deco -R $APP_PATH

USER deco

# Working gems separately
WORKDIR $APP_PATH

COPY --chown=deco:deco public/ $APP_PATH/public
COPY --chown=deco:deco package.json $APP_PATH/
COPY --chown=deco:deco package-lock.json $APP_PATH/
COPY --chown=deco:deco .eslintrc.json $APP_PATH/
COPY --chown=deco:deco entrypoint $APP_PATH/
COPY --chown=deco:deco node_modules/ $APP_PATH/node_modules
COPY --chown=deco:deco app/ $APP_PATH/app

RUN npm install

EXPOSE 3000

ENTRYPOINT [ "/home/deco/consumer-ui/entrypoint" ]
