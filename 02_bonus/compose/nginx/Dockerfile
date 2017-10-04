FROM nginx:1.11.9

#Remove default nginx conf
RUN rm /etc/nginx/conf.d/default.conf

RUN sed -ie "s/    include \/etc\/nginx\/conf.d\/\*\.conf\;/    include \/nginxConf\/\*\.conf\;/g" /etc/nginx/nginx.conf

VOLUME ["/nginxConf"]

EXPOSE 80

