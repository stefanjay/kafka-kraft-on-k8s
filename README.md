[![](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/build_and_push_on_merge.yml/badge.svg)](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/build_and_push_on_merge.yml)
[![](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/merge-tests.yaml/badge.svg)](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/merge-tests.yaml)
[![](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/security.md.yaml/badge.svg)](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/security.md.yaml)
[![](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/pages/pages-build-deployment)
[![](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kafka-kraft-on-k8s)](https://artifacthub.io/packages/search?repo=kafka-kraft-on-k8s)

# KRaft "Kafka Raft" on Kubernetes
Apache Kafka starting in version 3.3 is using the Raft metadata protocol to abandon the appendage ZooKeeper overhead to control the cluster's health.

<p float="left">
  <img src="https://images.contentful.com/gt6dp23g0g38/5ssqb8kUN6Lq5lR1EZdCX1/2a28415f8718dfec9edc345d9914dfec/new-quorum-controller-1536x817.png" width="300" />
  <img src="https://images.ctfassets.net/gt6dp23g0g38/5vGOBwLiNaRedNyB0yaiIu/529a29a059d8971541309f7f57502dd2/ingest-data-upstream-systems.jpg" width="280" />
</p>

More info can be found in the official Apache Kafka docs https://kafka.apache.org/documentation/#kraft



## News

#### Helm Chart released
- chart is soon available via Helm Repo
  
#### Public DockerHub Imageregistry
- https://hub.docker.com/r/kafkakraft/kafkakraft

## Table of Content
- [Helm Chart released](#helm-chart-released)
- [KRaft "Kafka Raft" on Kubernetes](#kraft-kafka-raft-on-kubernetes)
  - [Public DockerHub Imageregistry](#public-dockerhub-imageregistry)
  - [Table of Content](#table-of-content)
  - [Author](#author)
  - [Benefits](#benefits)
  - [Changelog](#changelog)
---

## Author
Stefan Jährling @ System Vertrieb Alexander GmbH

✨ As several repositories on github share similar approaches, I added my own. Inspired by some of them for you to try out. ✨

## Benefits

* Helm Chart (feat: RBAC, SA, HPA, AS)
- featuring a StatefulSet
- clustered with at least 3 nodes
- Kafka logdata on persistent volume /node
- environment variables in manifest
- up-to-date light-weight Kafka Connect Cluster
- add connectors as easy as build an image
- run´s in any containerized environment

  ## Changelog
v0.8
- repo refactored
- first helm release added

v0.7b
- fixed JMX definition
- fixed Kafka Connect Splunk connector integration

v0.7a
- fixed kafkaconnect
- minor changes in manifests
- fixed replication factor
- added topic autocreation env

v0.7
- fixed bug where kafka run as nonroot user in some circumstances
- bumped kafka-connect to 3.6.0
- bumped base image to openjdk.22-bookworm
- open fixme for DEFAULT_REPLICATION_FACTOR

v0.6
- bumped kafka to v3.6.0
- switched back to root user which runs kafka due to compatibility and open issue

v0.5a
- due to an unfixed bug, backported to kafka v3.3.2

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


----
### Donations are very welcome, this will motivate to sleep less and code harder :3 <br><br>[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/A0A1QHUNC) -- <a href="https://opencollective.com/kafka-kraft-on-k8s/donate" target="_blank"><img src="https://opencollective.com/webpack/donate/button@2x.png?color=blue" width=205></a>
