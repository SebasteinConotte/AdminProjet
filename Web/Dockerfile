FROM ubuntu:16.04

RUN apt-get update && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install \
apache2 php7.0 php7.0-mysql libapache2-mod-php7.0 curl lynx-cur


#copy des config des sites 
COPY b2B/b2b.w15.ephec-ti.be.conf /etc/apache2/site-available/b2b.w15.ephec-ti.be.conf
COPY intranet/intranet.w15.ephec-ti.be.conf /etc/apache2/site-available/intranet.w15.ephec-ti.be.conf
COPY showcase/w15.ephec-ti.be.conf /etc/apache2/site-available/w15.ephec-ti.be.conf

#copy des sites 
COPY b2B/html /var/www/b2b/html
COPY intranet/html /var/www/intranet/html
COPY showcase/html /var/www/default/html




# activer mod apache
RUN a2enmod php7.0
RUN a2enmod rewrite




#activer sites
#RUN ln -s /etc/apache2/site-available/b2B.conf  /etc/apache2/sites-enabled/
#RUN ln -s /etc/apache2/site-available/intranet.conf  /etc/apache2/sites-enabled/
#RUN ln -s /etc/apache2/site-available/showcase.conf  /etc/apache2/sites-enabled/
RUN a2ensite b2b.w15.ephec-ti.be.conf


EXPOSE 80 443

CMD [“/usr/sbin/httpd”, “-D”, “FOREGROUND”]

