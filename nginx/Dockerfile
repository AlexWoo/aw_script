FROM alexwoo/centos-dev
MAINTAINER AlexWoo <wj19840501@gmail.com>
WORKDIR /root/work

RUN mkdir -p nginx
WORKDIR nginx
COPY install_nginx ./
RUN ./install_nginx

EXPOSE 80
VOLUME /usr/local/nginx/logs/

CMD /usr/local/nginx/sbin/nginx;tail -f /usr/local/nginx/logs/error.log
