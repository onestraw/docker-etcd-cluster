FROM quay.io/coreos/etcd:v3.2.9

MAINTAINER Larry He<hexiaowei91@gmail.com>

# Some Environment Variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Install system dependencies
RUN apk update && \
    apk add net-tools supervisor gettext-dev wget curl && \
    rm -rf /var/cache/apk/*

RUN mkdir /etcd-conf
RUN mkdir /etcd-data
RUN mkdir /var/log/supervisor

COPY ./docker-data/etcd-cluster.yml /etcd-conf/etcd-cluster.yml

# Add supervisord configuration
COPY ./docker-data/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add startup script
COPY ./docker-data/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod 755 /docker-entrypoint.sh

EXPOSE 2376 2377 2378 2379

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["etcd-cluster"]
