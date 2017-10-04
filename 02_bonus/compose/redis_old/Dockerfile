FROM redis:3.2.7

VOLUME ["/data"]

EXPOSE 6379

#add our conf
COPY redis.conf /usr/local/etc/redis/redis.conf
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
