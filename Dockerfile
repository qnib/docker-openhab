FROM qnib/terminal
MAINTAINER "Christian Kniep <christian@qnib.org>"

RUN yum install -y java-1.8.0-openjdk-headless bsdtar
ENV OH_VER=1.8.0 \
    OH_TARGET_URL=https://openhab.ci.cloudbees.com/job/openHAB/lastSuccessfulBuild/artifact/distribution/target
RUN mkdir -p /opt/openhab/ && \
    curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-SNAPSHOT-runtime.zip|bsdtar xf - -C /opt/openhab/ && \
    chmod +x /opt/openhab/start.sh
RUN curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-SNAPSHOT-addons.zip|bsdtar xf - -C /opt/openhab/addons/
ADD etc/supervisord.d/openhab_runtime.ini /etc/supervisord.d/
ADD opt/openhab/configurations/ /opt/openhab/configurations/

