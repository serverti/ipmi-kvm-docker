FROM ubuntu:14.04
MAINTAINER Victor Andrade <victor@serverti.com.br>

ENV DEBIAN_FRONTEND noninteractive

RUN add-apt-repository ppa:mozillateam/ppa && apt-get update && apt-get -y install xvfb x11vnc wget \
    supervisor fluxbox icedtea-7-plugin net-tools python-numpy \
    chromium-browser firefox-esr
RUN sed -e '/^jdk.jar.disabledAlgorithms/s/^/#/' -i /usr/lib/jvm/java-7-openjdk-amd64/jre/lib/security/java.security
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /root/
RUN mkdir -p /root/images
ADD novnc /root/novnc/

ENV DISPLAY :0
ENV RES 1024x768x24
EXPOSE 8080
CMD ["/usr/bin/supervisord"]
