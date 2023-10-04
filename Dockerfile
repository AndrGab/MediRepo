FROM bitwalker/alpine-elixir:1.14.0 AS build

RUN apk update \
    && apk add --no-cache tzdata ncurses-libs postgresql-client build-base openssh-client \
    && cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
    && echo "America/Sao_Paulo" > /etc/timezone \
    && apk del tzdata

WORKDIR /app

ARG MIX_ENV=prod

RUN mix do local.hex --force, local.rebar --force

COPY mix.exs mix.lock ./
COPY config config

RUN mix do deps.get, deps.compile

COPY . ./
RUN mix do compile --warnings-as-errors, release

# production stage
FROM alpine:3.12 AS production

# install dependencies
RUN apk upgrade --no-cache && \
    apk add ncurses-libs curl libgcc libstdc++

# setup timezone
ENV TZ America/Sao_Paulo
RUN apk add --no-cache tzdata \
    && cp /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

# setup app
WORKDIR /app
ARG MIX_ENV=prod
COPY --from=build /app/_build/$MIX_ENV/rel/medirepo ./

# start application
COPY start.sh ./
CMD ["sh", "./start.sh"]