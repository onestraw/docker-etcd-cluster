#!/bin/sh

NODE_NUM=4
PORT_RANGE=`seq 2380 2383`
URL_PREFIX=http://0.0.0.0
TOKEN=etcd-cluster-docker-image
ALL_NODES=
for port in ${PORT_RANGE}; do
    ALL_NODES="etcd-$port=$URL_PREFIX:$port,$ALL_NODES"
done

if [ "$1" = 'etcd-cluster' ]; then
    for port in ${PORT_RANGE}; do
      mkdir -p /etcd-conf/${port}
      mkdir -p /etcd-data/${port}
    done

    for port in ${PORT_RANGE}; do
      CLIENT_PORT=`expr $port - $NODE_NUM`
      NODE_NAME=etcd-${port} DATA_DIR=/etcd-data/${port} FOR_PEER=${URL_PREFIX}:${port} FOR_CLIENT=${URL_PREFIX}:${CLIENT_PORT} NODES=${ALL_NODES} CLUSTER_TOKEN=${TOKEN} envsubst < /etcd-conf/etcd-cluster.yml > /etcd-conf/${port}/etcd.conf
    done

    supervisord -c /etc/supervisor/conf.d/supervisord.conf
    sleep 3

    tail -f /var/log/supervisor/etcd*.log
else
  exec "$@"
fi
