FROM alexwoo/centos-dev
MAINTAINER AlexWoo <wj19840501@gmail.com>
WORKDIR /root/work/ffmpeg

COPY ./ ./
RUN ./install_docker

CMD /usr/sbin/sshd -D
