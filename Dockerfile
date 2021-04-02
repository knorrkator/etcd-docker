FROM arm64v8/alpine:3.13 AS base

FROM base AS download
ARG ETCD_VERSION=v3.4.15
WORKDIR /down
RUN apk add --no-cache curl
RUN curl -Lo etcd.tar.gz "https://github.com/etcd-io/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-arm64.tar.gz"
RUN mkdir -p untared && tar -xzvf etcd.tar.gz -C untared --strip-components=1

FROM scratch AS result
COPY --from=download /down/untared/etcd /usr/local/bin/etcd
COPY --from=download /down/untared/etcdctl /usr/local/bin/etcdctl

ENV ETCD_UNSUPPORTED_ARCH=arm64

CMD /usr/local/bin/etcd
