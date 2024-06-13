# syntax=docker/dockerfile:labs
FROM haproxy:2.9.8-alpine3.20
USER root
COPY --from=zoeyvid/curl-quic:390 /usr/local/bin/curl /usr/local/bin/curl
RUN apk upgrade --no-cache -a && \
    apk add --no-cache ca-certificates tzdata tini openssl && \
    chown -R nobody:nobody /tmp
    
COPY start.sh /usr/local/bin/start.sh
COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY haproxy-no-post.cfg /etc/haproxy/haproxy-no-post.cfg
ENTRYPOINT ["tini", "--", "start.sh"]
HEALTHCHECK CMD (curl -sI http://localhost:2375 -o /dev/null && curl -skI https://localhost:2375 -o /dev/null) || exit 1

ENV ALLOW_POWER=0 \
    ALLOW_RESTART=0 \
    ALLOW_START=0 \
    ALLOW_STOP=0 \
    ALLOW_KILL=0 \
    AUTH=0 \
    BUILD=0 \
    COMMIT=0 \
    CONFIGS=0 \
    CONTAINERS=0 \
    DISTRIBUTION=0 \
    EVENTS=1 \
    EXEC=0 \
    GRPC=0 \
    IMAGES=0 \
    INFO=0 \
    NETWORKS=0 \
    NODES=0 \
    PING=1 \
    PLUGINS=0 \
    POST=0 \
    SECRETS=0 \
    SERVICES=0 \
    SESSION=0 \
    SOCKET_PATH=/var/run/docker.sock \
    SWARM=0 \
    SYSTEM=0 \
    TASKS=0 \
    VERSION=1 \
    VOLUMES=0 \
    NOPOST=0
