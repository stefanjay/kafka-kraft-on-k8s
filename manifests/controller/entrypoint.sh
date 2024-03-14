#!/bin/bash

if [[ $DEBUG == true ]]; then
    echo "DEBUG mode activated, sleep for a long time.."
    sleep 133333333333333337
    exit 1
fi

NODE_ID=$(echo $HOSTNAME | sed 's/[^0-9]*//g')
LISTENERS="CONTROLLER://:9093"

CONTROLLER_QUORUM_VOTERS=""
for i in $(seq 0 $(($CONTROLLER_REPLICAS - 1))); do
    CONTROLLER_QUORUM_VOTERS="$CONTROLLER_QUORUM_VOTERS$i@controller-$i.$CONTROLLER_SERVICE.$NAMESPACE.svc:9093,"
done
CONTROLLER_QUORUM_VOTERS=$(echo $CONTROLLER_QUORUM_VOTERS | sed 's/,$//')

mkdir -p $SHARE_DIR/$NODE_ID

if [[ $ENVS_ENABLED == true ]]; then
    if [[ $PROCESS_ROLES == 'controller' ]]; then

        sed -e "s+^process.roles=.*+process.roles=$PROCESS_ROLES+" \
            -e "s+^log.dirs=.*+log.dirs=$SHARE_DIR/$NODE_ID+" \
            -e "s+^node.id=.*+node.id=$NODE_ID+" \
            -e "s+^listeners=.*+listeners=$CONTROLLER_LISTENERS+" \
            -e "s+^controller.listeners.names=.*+controller.listeners.names=$CONTROLLER_LISTENER_NAMES+" \
            -e "s+^listener.security.protocol.map=.*+listener.security.protocol.map=$CONTROLLER_LISTENER_SECURITY_PROTOCOL_MAP+" \
            -e "s+^controller.quorum.voters=.*+controller.quorum.voters=$CONTROLLER_QUORUM_VOTERS+" \
            /opt/kafka/config/kraft/controller.properties > /opt/kafka/controller.properties.updated \
            && mv /opt/kafka/controller.properties.updated /opt/kafka/config/kraft/controller.properties

        kafka-storage.sh format -t $CLUSTER_ID -c /opt/kafka/config/kraft/controller.properties
        echo "[$(date +'%F %T.%3N')] INFO Kafka Controller properties loaded via ENVs"
        exec kafka-server-start.sh /opt/kafka/config/kraft/controller.properties
    fi

elif [[ $ENVS_ENABLED == false ]]; then
    if [[ $PROCESS_ROLES == 'controller' ]]; then

        cp /opt/kafka/config/kraft/properties/controller.properties /opt/kafka/config/kraft/controller.properties
        echo -e "\nnode.id=$NODE_ID" >> /opt/kafka/config/kraft/controller.properties
        kafka-storage.sh format -t $CLUSTER_ID -c /opt/kafka/config/kraft/controller.properties
        echo "[$(date +'%F %T.%3N')] INFO Kafka Controller properties loaded via ConfigMap"
        exec kafka-server-start.sh /opt/kafka/config/kraft/controller.properties
    fi

else
    echo "Invalid <ENABLED> helm value: $ENVS_ENABLED; values.yaml-line:43"
    sleep 1337
fi
