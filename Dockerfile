ARG ALPINE_VERSION=3.13
ARG GO_VERSION=1.23.6
ARG NODE_VERSION=18.20.7
# ARG VAULT_VERSION=1.19.0

# Stage 0: Clone the Vault repository
FROM --platform=$BUILDPLATFORM alpine:${ALPINE_VERSION} AS stage0
RUN apk add --no-cache git patch

# Clone the hashicorp/vault repository
# ARG VAULT_VERSION
# RUN git clone --depth=1 --branch=v${VAULT_VERSION} --single-branch https://github.com/hashicorp/vault.git /vault
RUN git clone --depth=1 --branch=channels/iroha-transit/main --single-branch https://github.com/soramitsukhmer-lab/vault.git /vault
WORKDIR /vault

# Stage 1: Build the UI
FROM --platform=$BUILDPLATFORM node:${NODE_VERSION}-alpine AS stage1
RUN apk add --no-cache git patch make
RUN corepack enable
COPY --from=stage0 /vault /vault
WORKDIR /vault
RUN --mount=type=cache,target=/root/.yarn/ \
    --mount=type=cache,target=/root/.cache/yarn \
    --mount=type=cache,target=/usr/local/share/.cache/yarn \
<<EOF
    cd ui/
    yarn install
    /usr/local/bin/npm rebuild node-sass
    yarn build
    rm -rf node_modules
EOF

# Stage 2: Build the Vault binary
FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS stage2
RUN apk add --no-cache bash git patch

# Copy the Vault source code from the previous stage
COPY --from=stage0 /vault /vault
COPY --from=stage1 /vault/http/web_ui/ /vault/http/web_ui/
WORKDIR /vault

# Build the Vault binary
ARG TARGETARCH
ARG DOCKER_META_VERSION=
RUN --mount=type=cache,target=/go/pkg/mod \
    --mount=type=cache,target=/root/.cache/go-build \
<<EOF
    go mod tidy

    cd sdk && {
        go mod tidy
        cd -
    }

    GIT_IMPORT="github.com/hashicorp/vault/version"
    GIT_COMMIT=$(git rev-parse --short HEAD)
    GIT_COMMIT_YEAR=$(git show -s --format=%cd --date=format:%Y HEAD)
    GIT_DIRTY=$(test -n "`git status --porcelain`" && echo "+CHANGES" || true)
    DATE_FORMAT="%Y-%m-%dT%H:%M:%SZ"
    GIT_DATE=$(date -u +${DATE_FORMAT})
    GOTAGS="vault ui"

    GOLDFLAGS="-w -s"
    GOLDFLAGS="${GOLDFLAGS} -X ${GIT_IMPORT}.GitCommit=${GIT_COMMIT}${GIT_DIRTY}"
    GOLDFLAGS="${GOLDFLAGS} -X ${GIT_IMPORT}.BuildDate=${GIT_DATE}"
    for GOARCH in amd64 arm64; do
        mkdir -p ./pkg/bin/linux_${GOARCH}
        CGO_ENABLED=0 GOOS=linux GOARCH=${GOARCH} go build -o ./pkg/bin/linux_${GOARCH} -tags "${GOTAGS}" -ldflags "${GOLDFLAGS}" .
    done
EOF

# Final stage
FROM alpine:${ALPINE_VERSION}

# Create a vault user and group first so the IDs get set the same way,
# even as the rest of this may change over time.
RUN addgroup vault && \
    adduser -S -G vault vault

# Set up certificates, our base tools, and Vault.
RUN set -eux; \
    apk add --no-cache ca-certificates libcap su-exec dumb-init tzdata

# # Copy the Vault binary from the build stage.
ARG TARGETARCH
COPY --from=stage2 /vault/pkg/bin/linux_${TARGETARCH}/vault /bin/vault

# /vault/logs is made available to use as a location to store audit logs, if
# desired; /vault/file is made available to use as a location with the file
# storage backend, if desired; the server will be started with /vault/config as
# the configuration directory so you can add additional config files in that
# location.
RUN mkdir -p /vault/logs && \
    mkdir -p /vault/file && \
    mkdir -p /vault/config && \
    chown -R vault:vault /vault

# Expose the logs directory as a volume since there's potentially long-running
# state in there
VOLUME /vault/logs

# Expose the file directory as a volume since there's potentially long-running
# state in there
VOLUME /vault/file

# 8200/tcp is the primary interface that applications use to interact with
# Vault.
EXPOSE 8200

# The entry point script uses dumb-init as the top-level process to reap any
# zombie processes created by Vault sub-processes.
#
# For production derivatives of this container, you should add the IPC_LOCK
# capability so that Vault can mlock memory.
COPY --from=stage2 /vault/scripts/docker/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# By default you'll get a single-node development server that stores everything
# in RAM and bootstraps itself. Don't use this configuration for production.
CMD ["server", "-dev"]
