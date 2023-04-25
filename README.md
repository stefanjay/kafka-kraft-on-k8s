![Image build status](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/docker-image.yml/badge.svg)
![Merge test status](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/merge-tests.yaml/badge.svg)

# KRaft "Kafka Raft" on Kubernetes
Apache Kafka starting in version 3.3 is using the Raft metadata protocol to abandon the appendage ZooKeeper overhead to control the cluster's health.

<p float="left">
  <img src="https://images.contentful.com/gt6dp23g0g38/5ssqb8kUN6Lq5lR1EZdCX1/2a28415f8718dfec9edc345d9914dfec/new-quorum-controller-1536x817.png" width="300" />
  <img src="https://images.ctfassets.net/gt6dp23g0g38/5vGOBwLiNaRedNyB0yaiIu/529a29a059d8971541309f7f57502dd2/ingest-data-upstream-systems.jpg" width="280" /> 
</p>

More info can be found in the official Apache Kafka docs https://kafka.apache.org/documentation/#kraft

#
## Table of Content
- [KRaft "Kafka Raft" on Kubernetes](#kraft-kafka-raft-on-kubernetes)
  - [Table of Content](#table-of-content)
  - [Author](#author)
  - [Benefits](#benefits)
  - [Environment variables](#environment-variables)
  - [HowTo](#howto)
  - [Changelog](#changelog)

#

## Author
Stefan Jährling @ System Vertrieb Alexander GmbH

✨ As several repositories on github share similar approaches, I added my own. Inspired by some of them for you to try out. ✨

## Benefits

- featuring a StatefulSet
- clustered with at least 3 nodes
- Kafka logdata on persistent volume /node
- environment variables in manifest
- up-to-date light-weight Kafka Connect Cluster
- add connectors as easy as build an image
- run´s in any containerized environment

## Environment variables
```yaml

set the default log replicas value
  - name: REPLICAS
    value: '3'

define the kubernetes service
  - name: SERVICE
    value: kafka-svc

set the used namespace used for the current deployment
  - name: NAMESPACE
    value: kafka

here you need to specify the path for the log storage
  - name: SHARE_DIR
    value: /mnt/kafka

choose a cluster UUID that every node uses to be able to join
  - name: CLUSTER_ID
    value: ys-gRE0zp9AusfyPBDNyON # $ kafka-storage.sh random-uuid; 16 bytes, see docs: https://kafka.apache.org/33/documentation.html#quickstart_startserver

choose the default replicatin factor
  - name: DEFAULT_REPLICATION_FACTOR
    value: '3'

a value for the minimum insync replicas
  - name: DEFAULT_MIN_INSYNC_REPLICAS
    value: '2'
```

## HowTo

#0   untar
  > tar xzf kafka-kraft.tar.gz

#1   build docker image
  > docker build -t myregistry/kafkakraft:<tag> . 
  > docker build -t myregistry/kafka-connect:<tag> ./kafka-connect/ 

#1b  push image to registry
  > docker push myregistry/kafkakraft:<tag>

#2   modify manifest to your needs
  > vi sts-kafkakraft.yaml

#3   deploy
  > k apply -f deploy-kafka.yaml

#4   watch deploy and check logs
  > k -n kafka get pod -w

  ## Changelog
v0.5a
- due to a unfixed bug, backported to kafka v3.3.2
  
v0.5
- added kafka-connect
- updated github actions

v0.4a
- bumping to kafka v3.4.0

v0.4
- bugfixed nonroot app-dir to /opt/kafka
- kafka data logdir in /mnt/kafka as persistentvolume
- CLUSTER_ID can now be set in the manifest as ENV

v0.3
- bugfix kafka random bootstrap error due to empty cluster_id (env var was not delivered)
- cluster_id is hard coded! until a fix is available
- seperate PVCs (100Gi) for each replica

v0.2
- added unprivileged user to run as non-root
- using kafka v3.3.2

v0.1
- added Dockerfile 
- updated entrypoint.sh
- switched to kafka v3.3.1
