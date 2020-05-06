FROM centos
MAINTAINER AlexWoo <wj19840501@gmail.com>
WORKDIR /root
COPY docker_centos_dev .
COPY flameperf.sh .

RUN ./docker_centos_dev
RUN mkdir work

VOLUME work

CMD init
