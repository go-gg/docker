#!/bin/bash

set -e
KUBE_VERSION=v1.19.0
KUBE_PAUSE_VERSION=3.2
ETCD_VERSION=3.4.9-1
CORE_DNS_VERSION=1.7.0

GCR_URL=k8s.gcr.io
ALIYUN_URL=feverzy/repo:

images=(kube-proxy:${KUBE_VERSION}
kube-scheduler:${KUBE_VERSION}
kube-controller-manager:${KUBE_VERSION}
kube-apiserver:${KUBE_VERSION}
kube-proxy:${KUBE_VERSION}
pause:${KUBE_PAUSE_VERSION}
etcd:${ETCD_VERSION}
coredns:${CORE_DNS_VERSION})

for imageName in ${images[@]} ; do
  docker tag  $GCR_URL/$imageName $ALIYUN_URL/$imageName
  docker pull $ALIYUN_URL/$imageName
  docker rmi $ALIYUN_URL/$imageName
done

#sapcc/tiller:v2.12.3 gcr.io/kubernetes-helm/tiller:v2.12.3


docker tag k8s.gcr.io/kube-apiserver:v1.19.0 feverzy/repo:kube-apiserver
docker tag k8s.gcr.io/kube-controller-manager:v1.19.0 feverzy/repo:kube-controller-manager
docker tag k8s.gcr.io/kube-scheduler:v1.19.0 feverzy/repo:kube-scheduler
docker tag k8s.gcr.io/kube-proxy:v1.19.0 feverzy/repo:kube-proxy
docker tag k8s.gcr.io/pause:3.2 feverzy/repo:pause
docker tag k8s.gcr.io/etcd:3.4.9-1 feverzy/repo:etcd
docker tag k8s.gcr.io/coredns:1.7.0 feverzy/repo:coredns


docker push feverzy/repo:kube-apiserver
docker push feverzy/repo:kube-controller-manager
docker push feverzy/repo:kube-scheduler
docker push feverzy/repo:kube-proxy
docker push feverzy/repo:pause
docker push feverzy/repo:etcd
docker push feverzy/repo:coredns

docker pull feverzy/repo:kube-apiserver
docker pull feverzy/repo:kube-controller-manager
docker pull feverzy/repo:kube-scheduler
docker pull feverzy/repo:kube-proxy
docker pull feverzy/repo:pause
docker pull feverzy/repo:etcd
docker pull feverzy/repo:coredns

docker tag feverzy/repo:kube-apiserver k8s.gcr.io/kube-apiserver:v1.19.0
docker tag feverzy/repo:kube-controller-manager k8s.gcr.io/kube-controller-manager:v1.19.0
docker tag feverzy/repo:kube-scheduler k8s.gcr.io/kube-scheduler:v1.19.0
docker tag feverzy/repo:kube-proxy k8s.gcr.io/kube-proxy:v1.19.0
docker tag feverzy/repo:pause k8s.gcr.io/pause:3.2
docker tag feverzy/repo:etcd k8s.gcr.io/etcd:3.4.9-1
docker tag feverzy/repo:coredns k8s.gcr.io/coredns:1.7.0

docker rmi feverzy/repo:kube-apiserver
docker rmi feverzy/repo:kube-controller-manager
docker rmi feverzy/repo:kube-scheduler
docker rmi feverzy/repo:kube-proxy
docker rmi feverzy/repo:pause
docker rmi feverzy/repo:etcd
docker rmi feverzy/repo:coredns