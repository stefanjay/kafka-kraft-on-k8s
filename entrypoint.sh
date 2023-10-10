#!/bin/bash

NODE_ID=${HOSTNAME:6}
LISTENERS="PLAINTEXT://:9092,CONTROLLER://:9093"
ADVERTISED_LISTENERS="PLAINTEXT://kafka-$NODE_ID.$SERVICE.$NAMESPACE.svc:9092"

CONTROLLER_QUORUM_VOTERS=""
for i in $( seq 0 $REPLICAS); do
    if [[ $i != $REPLICAS ]]; then
        CONTROLLER_QUORUM_VOTERS="$CONTROLLER_QUORUM_VOTERS$i@kafka-$i.$SERVICE.$NAMESPACE.svc:9093,"
    else
        CONTROLLER_QUORUM_VOTERS=${CONTROLLER_QUORUM_VOTERS::-1}
    fi
done

mkdir -p $SHARE_DIR/$NODE_ID

sed -e "s+^node.id=.*+node.id=$NODE_ID+" \
    -e "s+^num.partitions=.*+num.partitions=$KAFKA_NUM_PARTITIONS+" \
    -e "s+^controller.quorum.voters=.*+controller.quorum.voters=$CONTROLLER_QUORUM_VOTERS+" \
    -e "s+^listeners=.*+listeners=$LISTENERS+" \
    -e "s+^advertised.listeners=.*+advertised.listeners=$ADVERTISED_LISTENERS+" \
    -e "s+^log.dirs=.*+log.dirs=$SHARE_DIR/$NODE_ID+" \
    /opt/kafka/config/kraft/server.properties > /opt/kafka/server.properties.updated \
    && mv /opt/kafka/server.properties.updated /opt/kafka/config/kraft/server.properties

echo "default.replication.factor=$DEFAULT_REPLICATION_FACTOR" >> /opt/kafka/config/kraft/server.properties
echo "auto.create.topics.enable=$AUTO_CREATE_TOPICS_ENABLE" >> /opt/kafka/config/kraft/server.properties

kafka-storage.sh format -t $CLUSTER_ID -c /opt/kafka/config/kraft/server.properties

exec kafka-server-start.sh /opt/kafka/config/kraft/server.properties
