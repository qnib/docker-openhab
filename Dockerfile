FROM qnib/alplain-openjre8

ARG OH_TARGET_URL=https://bintray.com/artifact/download/openhab/bin
ENV OPENHAB_HOME=/opt/openhab/ \
    OPENHAB_HTTP_PORT=8080
ADD opt/qnib/openhab/bin/start.sh /opt/qnib/openhab/bin/start.sh

ARG OH_VER=1.8.3
WORKDIR /opt/openhab/
RUN apk --no-cache add wget unzip \
 && wget -q ${OH_TARGET_URL}/distribution-${OH_VER}-runtime.zip \
 && unzip distribution-${OH_VER}-runtime.zip
RUN chmod +x /opt/openhab/start.sh
RUN wget -q ${OH_TARGET_URL}/distribution-${OH_VER}-addons.zip \
 && unzip -nq distribution-${OH_VER}-addons.zip
COPY opt/openhab/configurations/ /opt/openhab/configurations/
CMD ["/opt/qnib/openhab/bin/start.sh"]
