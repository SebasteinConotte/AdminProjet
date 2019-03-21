FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
apache2 php7.0 php7.0-mysql libapache2-mod-php7.0 curl lynx-cur


#copy des config des sites 
COPY b2B/b2B.conf /etc/apache2/site-available/b2B.conf
COPY intranet/intranet.conf /etc/apache2/site-available/intranet.conf
COPY showcase/showcase.conf /etc/apache2/site-available/showcase.conf

#copy des sites 
COPY b2B/html /var/www/b2b/html
COPY intranet/html /var/www/intranet/html
COPY showcase/html /var/www/default/html




# activer mod apache
RUN a2enmod php7.0
RUN a2enmod rewrite

#activer sites
RUN a2ensite b2B
RUN a2ensite intranet
RUN a2ensite showcase

RUN service apache2 restart

EXPOSE 80 443

CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]

