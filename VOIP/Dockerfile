FROM ubuntu:16.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install build-essential wget libssl-dev libncurses5-dev  logrotate rsyslog \
    libnewt-dev libxml2-dev linux-headers-$(uname -r) uuid-dev \
    libsqlite3-dev libjansson-dev  \
    subversion && \
    wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-15-current.tar.gz && \
    tar -xzvf asterisk-15-current.tar.gz &&  \
    cd asterisk-15.*/  && \
    ./contrib/scripts/get_mp3_source.sh && \
    ./configure && \
    make menuselect.makeopts && \
    menuselect/menuselect \
    --enable CORE-SOUNDS-FR-ULAW \
    --enable MOH-OPSOUND-ULAW \
    --enable EXTRA-SOUNDS-FR-ULAW \
    menuselect.makeopts && \
    make && make install  && make samples && make config && \
    apt-get clean 

ADD  https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/VOIP/config/sip.conf /etc/asterisk/sip.conf
ADD  https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/VOIP/config/users.conf /etc/asterisk/users.conf
ADD  https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/VOIP/config/extensions.conf /etc/asterisk/extensions.conf
ADD  https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/VOIP/config/voicemail.conf /etc/asterisk/voicemail.conf
ADD  https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/VOIP/config/queues.conf /etc/asterisk/queues.conf
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/VOIP/config/features.conf /etc/asterisk/features.conf
ADD https://raw.githubusercontent.com/SebasteinConotte/AdminProjet/master/VOIP/config/asterisk /etc/logrotate.d/asterisk


RUN sed -i "s/rtpstart=10000/rtpstart=16384/g" /etc/asterisk/rtp.conf
RUN sed -i "s/rtpend=20000/rtpend=16394/g" /etc/asterisk/rtp.conf

RUN logrotate /etc/logrotate.conf

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
    
CMD asterisk -fvvvvv
    


    
