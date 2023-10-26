# Kafka KRaft on K8s Helm Chart (K4C) Repository

## Add the 'Kafka KRaft on K8s' Helm repository

```
helm repo add kafka-kraft-on-k8s https://stefanjay.github.io/kafka-kraft-on-k8s/
```

### In case the repository already exists, upgrade to the latest version

```bash
helm repo update kafka-kraft-on-k8s
```

## Install the 'Kafka KRaft on K8s' Chart

This will install a 'Kafka KRaft on K8s' with three nodes.

Refer to the offical Kafka documentation for more information https://kafka.apache.org/documentation/#configuration

```
helm install stable kafka-kraft-on-k8s/kafka-kraft-on-k8s
```
