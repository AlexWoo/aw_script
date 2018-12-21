FROM centos
MAINTAINER AlexWoo <wj19840501@gmail.com>
WORKDIR /root

# base package
RUN yum install -y wget make gcc git openssl epel-release
RUN yum install -y golang

# install libsrtp
RUN git clone https://github.com/AlexWoo/gortc.git
RUN cd gortc && ./install
RUN rm -rf *

CMD /usr/local/gortc/bin/gortc
