FROM node:latest

COPY package.json /tmp/
RUN apt-get update ; apt-get install -y curl
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN cd /tmp && yarn

# Create our app directory and then symlink the
# node_modules folder to the app directory.
RUN mkdir /app \
    && cd /app \
    && ln -s /tmp/node_modules

WORKDIR /app
COPY . /app

VOLUME ["/app"]

EXPOSE 3001
CMD ["node", "app.js"]
