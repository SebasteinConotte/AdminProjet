FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
apache2 php7.0 php7.0-mysql libapache2-mod-php7.0 curl lynx-cur


#copy des config des sites 
copy /b2B/b2B.conf /etc/apache2/site-available/
copy /intranet/intranet.conf /etc/apache2/site-available/
copy /showcase/showcase.conf /etc/apache2/site-available/

#copy des sites 
copy /b2B/html /var/www/b2b/html
copy /intranet/html /var/www/intranet/html
copy /showcase/html /var/www/default/html




# activer mod apache
RUN a2enmod php7.0
RUN a2enmod rewrite

#activer sites
RUN a2ensite b2B.conf
RUN a2ensite intranet.conf
RUN a2ensite showcase.conf


EXPOSE 80 443

CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]

