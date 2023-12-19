[![](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/build_and_push_on_merge.yml/badge.svg)](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/build_and_push_on_merge.yml)
[![](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/merge-tests.yaml/badge.svg)](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/merge-tests.yaml)
[![](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/check_apachekafka_release.yaml/badge.svg)](https://github.com/stefanjay/kafka-kraft-on-k8s/actions/workflows/check_apachekafka_release.yaml)
[![](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kafka-kraft-on-k8s)](https://artifacthub.io/packages/search?repo=kafka-kraft-on-k8s)

# Kafka KRaft on Kubernetes Helm Chart (K4C)
Apache Kafka starting in version 3.3 is using the Raft metadata protocol production ready to abandon the appendage ZooKeeper overhead to control the cluster's health.

<p float="left">
  <img src="https://images.contentful.com/gt6dp23g0g38/5ssqb8kUN6Lq5lR1EZdCX1/2a28415f8718dfec9edc345d9914dfec/new-quorum-controller-1536x817.png" width="300" />
  <img src="https://images.ctfassets.net/gt6dp23g0g38/5vGOBwLiNaRedNyB0yaiIu/529a29a059d8971541309f7f57502dd2/ingest-data-upstream-systems.jpg" width="280" />
</p>

More info can be found in the official Apache Kafka docs https://kafka.apache.org/documentation/#kraft



## News

#### Helm Chart released
- chart is available via Helm Repo -> https://stefanjay.github.io/kafka-kraft-on-k8s/
  
#### Public DockerHub Imageregistry
- https://hub.docker.com/r/kafkakraft/kafkakraft

## Table of Content
- [Helm Chart released](#helm-chart-released)
- [Kafka KRaft on Kubernetes Helm Chart (K4C)](#kafka-kraft-on-kubernetes-helm-chart-k4c)
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
- runs in any containerized environment

# Changelog

#### [v1.0.1]
- Minor fix (package version, image name in values.yaml)
#### [v1.0.0]
- Refactored repository structure
- First Helm release
#### [v0.7b]
- JMX definition
- Kafka Connect Splunk integration
#### [v0.7a]
- Kafka Connect
- Minor manifest changes
- Replication factor
- Added topic autocreation env
#### [v0.7]
- Bug: Kafka runs as nonroot user in some cases
- Bumped Kafka Connect to v3.6.0
- Bumped base image to openjdk.22-bookworm
- Open fixme for DEFAULT_REPLICATION_FACTOR
#### [v0.6]
- Bumped Kafka to v3.6.0
- Switched back to root user for compatibility
#### [v0.5a]
- Backported to Kafka v3.3.2 due to unfixed bug
#### [v0.5]
- Kafka Connect
- Updated GitHub Actions
#### [v0.4a]
- Bumped Kafka to v3.4.0
#### [v0.4]
- Bugfixed nonroot app-dir to /opt/kafka
- Kafka data logdir in /mnt/kafka as PV
- CLUSTER_ID can be set in manifest as ENV
#### [v0.3]
- Bugfix: Kafka random bootstrap error due to empty cluster_id
- Cluster_id is hard coded until fix
- Separate PVCs (100Gi) for each replica
#### [v0.2]
- Unprivileged user to run as non-root
- Using Kafka v3.3.2
#### [v0.1]
- Dockerfile
- Updated entrypoint.sh
- Switched to Kafka v3.3.1


----
### Donations are very welcome, this will motivate to sleep less and code harder :3 <br><br>[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/A0A1QHUNC) -- <a href="https://opencollective.com/kafka-kraft-on-k8s/donate" target="_blank"><img src="https://opencollective.com/webpack/donate/button@2x.png?color=blue" width=205></a>
