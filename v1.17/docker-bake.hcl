variable "VAULT_VERSION" {
    default = "1.17.6"
}

target "docker-metadata-action" {}

target "default" {
    inherits = ["docker-metadata-action"]
    contexts = {
      "iroha-transit-builder" = "target:iroha-transit-builder"
    }
    args = {
        VAULT_VERSION = "${VAULT_VERSION}"
    }
    tags = [
        "soramitsukhmer-lab/vault:${VAULT_VERSION}-dev"
    ]
}

target "release" {
    inherits = ["docker-metadata-action"]
    args = {
        VAULT_VERSION = "${VAULT_VERSION}"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64"
    ]
    tags = [
        "harbor.sorakh.io/soramitsukhmer-lab/vault:${VAULT_VERSION}"
    ]
}

target "iroha-transit-builder" {
    context = "https://github.com/soramitsukhmer-lab/vault-plugin-iroha-transit-secrets.git"
}
