FROM elixir:1.5
ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_PATH=/firestorm-node_modules

RUN apt-get update -qq && \
    apt-get upgrade -qq && \
    apt-get install -q -y \
      postgresql-client \
      inotify-tools \
      vim && \
    apt-get -y autoremove && \
    apt-get -y autoclean

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn brunch

RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force

RUN mkdir /firestorm-build
RUN mkdir /firestorm-deps
RUN mkdir /firestorm
ADD . /firestorm
WORKDIR /firestorm

# App is configured to store in /firestorm-deps
RUN mix deps.get

# Precompile for prod to speed up deploys
RUN MIX_ENV=prod mix compile

# Yarn is not creating the .bin for custom dirs, have to hack around it
# RUN yarn install && mv node_modules ${NODE_PATH}
RUN yarn install --modules-folder=${NODE_PATH}

EXPOSE 4000
