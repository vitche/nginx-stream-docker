FROM debian:stretch

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y wget libpcre3-dev build-essential libssl-dev zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt

RUN wget http://nginx.org/download/nginx-1.12.2.tar.gz && \
    tar -zxvf nginx-1.*.tar.gz && \
    cd nginx-1.* && \
    ./configure --prefix=/opt/nginx --user=nginx --group=nginx --with-http_ssl_module --with-ipv6 --with-threads --with-stream --with-stream_ssl_module && \
    make && make install && \
    cd .. && rm -rf nginx-1.*

# nginx user
RUN adduser --system --no-create-home --disabled-login --disabled-password --group nginx

WORKDIR /

CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
