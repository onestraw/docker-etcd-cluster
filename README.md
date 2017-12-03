# docker-etcd-cluster

The idea is from [docker-redis-cluster](https://github.com/Grokzen/docker-redis-cluster)

https://coreos.com/etcd/docs/latest/v2/docker_guide.html


# Usage

There is 2 primary ways of buliding and running this container


## docker build

To build your own image run:

    docker build -t <username>/etcd-cluster .

    # or

    make build

And to run the container use:

    docker run -it -p 2376:2376 -p 2377:2377 -p 2378:2378 -p 2379:2379

    # or

    make run

    # and top stop the container run

    make stop

To connect to your cluster you can use the etcdctl tool:

    etcdctl set /authr Larry

    etcdctl get /authr
