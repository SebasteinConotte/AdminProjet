FROM ubuntu:16.04

RUN apt-get update && \
    apt-get install build-essential wget libssl-dev libncurses5-dev \
    libnewt-dev libxml2-dev linux-headers-$(uname -r) uuid-dev \
    libsqlite3-dev libjansson-dev && \
    wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-15-current.tar.gz && \
    tar -xzvf asterisk-15-current.tar.gz && 
    cd asterisk-15.*/  && \
    ./contrib/scripts/get_mp3_source.sh && \
    ./contrib/scripts/install_prereq install && \
    ./configure && \
    make menuselect.makeopts && \
    menuselect/menuselect \
    --enable CORE-SOUNDS-FR-ULAW \
    --enable MOH-OPSOUND-ULAW \
    --enable EXTRA-SOUNDS-FR-ULAW \
    menuselect.makeopts && \
    make && make install  && make samples && make config && \
    apt-get clean 

ADD "lien" /etc/asterisk/sip.conf
ADD "lien" /etc/asterisk/users.conf
ADD "lien" /etc/asterisk/extensions.conf
ADD "lien" /etc/asterisk/voicemail.conf
ADD "lien" /etc/asterisk/queues.conf


EXPOSE 5060 5060/udp
EXPOSE 16384/udp
EXPOSE 16385/udp
EXPOSE 16386/udp
EXPOSE 16387/udp
EXPOSE 16388/udp
EXPOSE 16389/udp
EXPOSE 16390/udp
EXPOSE 16391/udp
EXPOSE 16392/udp
EXPOSE 16393/udp
EXPOSE 16394/udp
    
CMD ["/usr/sbin/asterisk", "-vvvdddf", "-T", "-W", "-U", "asterisk", "-p"]  
    


    