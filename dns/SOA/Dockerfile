FROM ubuntu:16.04

RUN apt-get update && apt-get install -y bind9

WORKDIR /etc/bind

VOLUME /etc/bind



COPY ./config/named.conf /etc/bind/named.conf
COPY ./config/named.conf.options /etc/bind/named.conf.options
COPY ./config/named.conf.default-zones /etc/bind/named.conf.default-zones
COPY ./config/named.conf.local /etc/bind/named.conf.local
COPY ./config/db.w15.ephec-ti.be /etc/bind/db.w15.ephec-ti.be
COPY ./config/db.int.w15.ephec-ti.be /etc/bind/db.int.w15.ephec-ti.be

EXPOSE 53 53/udp

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]
