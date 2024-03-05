#!/bin/bash

CNF=/opt/kafka/config/connect-distributed.properties

sed -e "s+^bootstrap.servers=.*+bootstrap.servers=$SERVICE.$NAMESPACE.svc:9092+" \
    -e "s+^key.converter=.*+key.converter=$KEY_CONVERTER+" \
    -e "s+^value.converter=.*+value.converter=$VALUE_CONVERTER+" \
    -e "s+^key.converter.schemas.enable=.*+key.converter.schemas.enable=$KEY_CONVERTER_SCHEMAS_ENABLE+" \
    -e "s+^value.converter.schemas.enable=.*+value.converter.schemas.enable=$VALUE_CONVERTER_SCHEMAS_ENABLE+" \
    -e "s+^offset.storage.replication.factor=.*+offset.storage.replication.factor=$OFFSET_STORAGE_REPLICATION_FACTOR+" \
    -e "s+^offset.storage.partitions=.*+offset.storage.partitions=$OFFSET_STORAGE_PARTITIONS+" \
    -e "s+^offset.storage.cleanup.policy=.*+offset.storage.cleanup.policy=$OFFSET_STORAGE_CLEANUP_POLICY+" \
    -e "s+^status.storage.replication.factor=.*+status.storage.replication.factor=$STATUS_STORAGE_REPLICATION_FACTOR+" \
    -e "s+^status.storage.partitions=.*+status.storage.partitions=$STATUS_STORAGE_PARTITIONS+" \
    -e "s+^listeners=.*+listeners=$LISTENERS+" \
    -e "s+^plugin.path=.*+plugin.path=$PLUGIN_PATH+" \
    $CNF > $CNF.updated \
    && mv $CNF.updated $CNF

exec connect-distributed.sh $CNF
