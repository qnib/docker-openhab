FROM qnib/java8

ENV OH_VER=1.8.0 \
    OH_TARGET_URL=https://openhab.ci.cloudbees.com/job/openHAB/lastSuccessfulBuild/artifact/distribution/target
RUN yum install -y bsdtar
RUN mkdir -p /opt/openhab/ && \
    curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-SNAPSHOT-runtime.zip|bsdtar xf - -C /opt/openhab/ && \
    chmod +x /opt/openhab/start.sh
RUN curl -fsL ${OH_TARGET_URL}/distribution-${OH_VER}-SNAPSHOT-addons.zip|bsdtar xf - -C /opt/openhab/addons/ && \
    cd /opt/openhab/addons/ && \
    rm -f org.openhab.binding.sonos-1.8.0-SNAPSHOT.jar && \
    rm -f org.openhab.binding.bluetooth-1.8.0-SNAPSHOT.jar && \
    rm -f org.openhab.binding.souliss-1.8.0-SNAPSHOT.jar 
ADD etc/supervisord.d/openhab_runtime.ini /etc/supervisord.d/
ADD opt/openhab/configurations/ /opt/openhab/configurations/

