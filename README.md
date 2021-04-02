# etcd-docker
Minimal Dockerfile for etcd running on ARM/Raspberry PI

# Build
```
docker build -t etcd-docker .
```

# Run
```
mkdir -p /var/lib/etcd
docker run \
  -d \
  -p 2379:2379 \
  -p 2380:2380 \
  --mount type=bind,source=/var/lib/etcd,destination=/etcd-data \
  --name etcd \
  --rm \
  etcd-docker \
  /usr/local/bin/etcd \
  --name s1 \
  --data-dir /etcd-data \
  --listen-client-urls http://0.0.0.0:2379 \
  --advertise-client-urls http://0.0.0.0:2379 \
  --listen-peer-urls http://0.0.0.0:2380 \
  --initial-advertise-peer-urls http://0.0.0.0:2380 \
  --initial-cluster s1=http://0.0.0.0:2380 \
  --initial-cluster-token tkn \
  --initial-cluster-state new
```
