FROM centos
MAINTAINER AlexWoo <wj19840501@gmail.com>
WORKDIR /root

# base package
RUN yum install -y wget make gcc git openssl epel-release
RUN yum install -y libmicrohttpd-devel jansson-devel libnice-devel openssl-devel glib-devel opus-devel libogg-devel libcurl-devel pkgconfig gengetopt libtool autoconf automake cmake

# install libsrtp
RUN wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz
RUN tar xzf v2.2.0.tar.gz
RUN cd libsrtp-2.2.0 && ./configure --prefix=/usr --enable-openssl && make shared_library && make install

# install libwebsockets
RUN git clone https://github.com/warmcat/libwebsockets.git
RUN mkdir build
RUN cd build && cmake -DLWS_MAX_SMP=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" ../libwebsockets && make && make install
RUN echo /usr/lib > /etc/ld.so.conf.d/janus.conf
RUN ldconfig
RUN ln -s /usr/lib/pkgconfig/libsrtp.pc /usr/lib64/pkgconfig/libsrtp.pc

# install janus
RUN useradd janus -M -r -s /sbin/nologin
RUN git clone --branch 1.0.1 https://github.com/AlexWoo/janus-gateway.git
RUN cd janus-gateway && sh autogen.sh && ./configure --prefix=/usr/local/janus --disable-rabbitmq --disable-mqtt && make && make install && make configs
RUN mkdir -p /usr/local/janus/logs
RUN mkdir -p /usr/local/janus
RUN chown -R janus:janus /usr/local/janus
RUN sed -i "s/^http = yes/http = no/g" /usr/local/janus/etc/janus/janus.transport.http.cfg

# genkey
RUN mkdir -p /usr/local/janus/certs
RUN openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=AU/ST=NSW/L=Sydney/O=JanusDemo/CN=rtc.test.com" -keyout /usr/local/janus/certs/mycert.key -out /usr/local/janus/certs/mycert.pem

RUN rm -rf *

CMD /usr/local/janus/bin/janus -L /usr/local/janus/logs/janus.log -s 60
