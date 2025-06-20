ARG VAULT_VERSION=latest
ARG VAULT_PLUGIN_CATALOG_VERSION=0.1.0-rc.7

FROM hashicorp/vault:${VAULT_VERSION}
ARG TARGETARCH
ARG VAULT_PLUGIN_CATALOG_VERSION
ADD --chmod=0755 https://github.com/soramitsukhmer-lab/vault-plugin-catalog/releases/download/v${VAULT_PLUGIN_CATALOG_VERSION}/vault-plugin-catalog-linux-${TARGETARCH} /usr/local/bin/vault-plugin-catalog
ADD rootfs /
