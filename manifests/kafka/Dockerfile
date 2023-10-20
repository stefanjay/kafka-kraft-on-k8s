FROM openjdk:22-bookworm

ENV KAFKA_VERSION=3.6.0
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin

RUN addgroup --gid 1001 kafka \
 && adduser  --uid 1001 --gid 1001 kafka --home /home/kafka

RUN install -d -o kafka -g kafka /opt

USER kafka

LABEL name="kafkakraft" version=${KAFKA_VERSION}

RUN wget -O /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
 && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
 && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
 && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}

COPY ./manifests/kafka/jmx-exporter-config.yaml /opt/jmx-exporter-config.yaml
RUN wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.17.2/jmx_prometheus_javaagent-0.17.2.jar -O /opt/jmx_prometheus_javaagent-0.17.2.jar
ENV KAFKA_OPTS="-javaagent:/opt/jmx_prometheus_javaagent-0.17.2.jar=9000:/opt/jmx-exporter-config.yaml"

COPY --chown=kafka:kafka ./entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
