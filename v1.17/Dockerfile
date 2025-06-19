ARG VAULT_VERSION=latest
ARG IROHA_TRANSIT_RELEASE=https://github.com/soramitsukhmer-lab/poc-vault-iroha-integration/releases/download
ARG IROHA_TRANSIT_VERSION=0.0.1-alpha.1

FROM hashicorp/vault:${VAULT_VERSION}
ARG TARGETARCH
ARG IROHA_TRANSIT_RELEASE
ARG IROHA_TRANSIT_VERSION
ADD --chmod=0755 ${IROHA_TRANSIT_RELEASE}/${IROHA_TRANSIT_VERSION}/iroha-transit-${IROHA_TRANSIT_VERSION}-linux-${TARGETARCH} /vault/plugins/iroha-transit-${IROHA_TRANSIT_VERSION}
ADD rootfs /
