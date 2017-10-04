FROM node:8.1.2

COPY package.json /tmp/
RUN cd /tmp && npm install

# Create our app directory and then symlink the
# node_modules folder to the app directory.
RUN mkdir /app \
    && cd /app \
    && ln -s /tmp/node_modules

WORKDIR /app
COPY . /app

VOLUME ["/app"]

EXPOSE 3000
CMD ["npm", "run", "docker"]
