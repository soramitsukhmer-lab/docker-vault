ARG VAULT_VERSION=latest

FROM iroha-transit-builder AS iroha-transit

FROM hashicorp/vault:${VAULT_VERSION}
ADD rootfs /
ARG TARGETARCH
COPY --from=iroha-transit /iroha-transit-linux-${TARGETARCH} /vault/plugins/iroha-transit
