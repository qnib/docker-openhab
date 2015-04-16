FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN yum install -y java-1.8.0-openjdk
RUN mkdir -p /opt/openhab && cd /opt/openhab  && \
    curl -Ls -o /opt/distribution-1.6.2-runtime.zip  https://github.com/openhab/openhab/releases/download/v1.6.2/distribution-1.6.2-runtime.zip && \
    unzip -q /opt/distribution-1.6.2-runtime.zip && \
    rm -f /opt/distribution-1.6.2-runtime.zip
ADD etc/supervisord.d/openhab_runtime.ini /etc/supervisord.d/
ADD opt/openhab/addons/ /opt/openhab/addons/
ADD opt/openhab/configurations/ /opt/openhab/configurations/

