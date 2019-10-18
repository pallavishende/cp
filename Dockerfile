# Using node10 (LTS)
FROM node:10-alpine as content-platform

LABEL "Author"="Andrew Kemp <andrew.kemp@viacomcontractor.com>"
LABEL "Version"="1.0"

# Install bash
RUN apk add --update bash && rm -rf /var/cache/apk/*

# Install cURL
RUN apk --no-cache add curl

# Install git
RUN apk --no-cache add git

# Install Yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
# RUN apk add yarn
ENV PATH "$PATH:/opt/yarn/bin"
RUN yarn --version

# Create app directory
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN node --version

## Install Deps
COPY package.json yarn.lock .npmrc angular.json nx.json /usr/src/app/
RUN yarn install --no-cache --pure-lockfile --silent --non-interactive && \
  yarn cache clean

EXPOSE 4200 49152
CMD [ "yarn", "start" ]
