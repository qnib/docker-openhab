FROM qnib/java8

ARG OH_TARGET_URL=https://bintray.com/artifact/download/openhab/bin
ENV OPENHAB_HOME=/opt/openhab/ \
    OPENHAB_HTTP_PORT=8080
ADD etc/supervisord.d/*.ini /etc/supervisord.d/
ADD opt/openhab/configurations/ /opt/openhab/configurations/
ADD opt/qnib/openhab/bin/start.sh /opt/qnib/openhab/bin/start.sh

ARG OH_VER=1.8.3
RUN mkdir -p /opt/openhab/ && \
    curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-runtime.zip|bsdtar xf - -C /opt/openhab/ && \
    chmod +x /opt/openhab/start.sh
RUN curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-addons.zip|bsdtar xf - -C /opt/openhab/addons/
RUN curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-greent.zip|bsdtar xf - -C /opt/openhab/webapps/
