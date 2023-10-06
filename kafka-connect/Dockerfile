FROM openjdk:21-bullseye

ENV KAFKA_VERSION=3.6.0
ENV SCALA_VERSION=2.13
ENV KAFKA_HOME=/opt/kafka
ENV PATH=${PATH}:${KAFKA_HOME}/bin

RUN addgroup --gid 1001 kafka \
 && adduser  --uid 1001 --gid 1001 kafka --home /home/kafka

RUN install -d -o kafka -g kafka /opt

USER kafka

LABEL name="kafka-connect" version=${KAFKA_VERSION}

RUN wget -O /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
 && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
 && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
 && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME}

COPY ./kafka-connect/connect-distributed.properties  /opt/kafka/config/connect-distributed.properties

COPY ./kafka-connect/entrypoint.sh /
ENTRYPOINT ["/bin/bash", "/entrypoint.sh"]
