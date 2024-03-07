#!/bin/bash

NODE_ID=$(echo $HOSTNAME | sed 's/[^0-9]*//g')
LISTENERS="CONTROLLER://:9093"

CONTROLLER_QUORUM_VOTERS=""
for i in $(seq 0 $(($CONTROLLER_REPLICAS - 1))); do
    CONTROLLER_QUORUM_VOTERS="$CONTROLLER_QUORUM_VOTERS$i@controller-$i.$CONTROLLER_SERVICE.$NAMESPACE.svc:9093,"
done
CONTROLLER_QUORUM_VOTERS=$(echo $CONTROLLER_QUORUM_VOTERS | sed 's/,$//')

mkdir -p $SHARE_DIR/$NODE_ID

    ADVERTISED_LISTENERS=""
    sed -e "s+^controller.quorum.voters=.*+controller.quorum.voters=$CONTROLLER_QUORUM_VOTERS+" \
        -e "s+^listeners=.*+listeners=$LISTENERS+" \
        -e "s+^log.dirs=.*+log.dirs=$SHARE_DIR/$NODE_ID+" \
        -e "s+^node.id=.*+node.id=$NODE_ID+" \
        -e "s+^process.roles=.*+process.roles=$PROCESS_ROLES+" \
        -e "s+^controller.listeners.names=.*+controller.listeners.names=$CONTROLLER_LISTENER_NAMES+" \
        -e "s+^listener.security.protocol.map=.*+listener.security.protocol.map=$CONTROLLER_LISTENER_SECURITY_PROTOCOL_MAP+" \
        /opt/kafka/config/kraft/controller.properties > /opt/kafka/controller.properties.updated \
        && mv /opt/kafka/controller.properties.updated /opt/kafka/config/kraft/controller.properties

kafka-storage.sh format -t $CLUSTER_ID -c /opt/kafka/config/kraft/controller.properties
exec kafka-server-start.sh /opt/kafka/config/kraft/controller.properties
