FROM ubuntu:16.04

RUN apt-get update && apt-get install apache2

CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]

EXPOSE 80 443
