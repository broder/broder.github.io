FROM ruby:2.6.0-slim

ENV LANG C.UTF-8

LABEL "com.github.actions.name"="Jekyll Development"
LABEL "com.github.actions.description"="A Jekyll development environment with Ruby, Node and Chrome setup."
LABEL "com.github.actions.icon"="command"
LABEL "com.github.actions.color"="red"

# Install node & pa11y dependencies
# Adapted from https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker
RUN apt-get update -q && apt-get install -qq wget git gnupg libcurl4-openssl-dev build-essential ruby-dev

RUN wget -q -O - https://deb.nodesource.com/setup_11.x | bash -
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

RUN apt-get update -q && apt-get install -qq \
  nodejs \
  libgconf-2-4 google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst ttf-freefont

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true
COPY ./pa11y.json /
ENV PA11Y_CONFIG /pa11y.json

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
