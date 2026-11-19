# syntax=docker/dockerfile:1.29.0@sha256:572cebbc2b15e6f84c077742952674889cb63cd5e9b80abdffcbe587b6f19183
FROM haproxy:3.4.8-alpine3.24@sha256:0f4ac017b3a028170f9727f0f0865cfae9264519efa5b7c7d31606ce4777f8bc
USER 0:0
RUN apk upgrade --no-cache -a && \
    apk add --no-cache tzdata tini openssl su-exec curl && \
    chown -R nobody:nobody /tmp
    
COPY start.sh /usr/local/bin/start.sh
COPY haproxy.cfg /etc/haproxy/haproxy.cfg
ENTRYPOINT ["tini", "--", "start.sh"]
HEALTHCHECK CMD ["/bin/sh", "-c", "[ \"$(curl -sSfL http://localhost:2375/_ping)\" = \"OK\" ] && [ \"$(curl -sSfLk https://localhost:2375/_ping)\" = \"OK\" ] && [ \"$(curl -sSfLk https://localhost:2376/_ping)\" = \"OK\" ]"]

ENV ALLOW_POWER=0 \
    ALLOW_RESTART=0 \
    ALLOW_RESTARTS=0 \
    ALLOW_START=0 \
    ALLOW_STOP=0 \
    ALLOW_KILL=0 \
    ALLOW_PAUSE=0 \
    ALLOW_UNPAUSE=0 \
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
    ALL=0
