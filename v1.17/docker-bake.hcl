variable "VAULT_VERSION" { default = "1.17.6" }
variable "IROHA_TRANSIT_REF" { default = "v1.17" }

target "docker-metadata-action" {}

target "vault" {
    inherits = ["docker-metadata-action"]
    contexts = {
      "iroha-transit-builder" = "target:iroha-transit-builder"
    }
    args = {
        VAULT_VERSION = "${VAULT_VERSION}"
    }
}

target "iroha-transit-builder" {
    context = "https://github.com/soramitsukhmer-lab/vault-plugin-iroha-transit-secrets.git#${IROHA_TRANSIT_REF}"
}

target "default" {
    inherits = ["vault"]
    tags = [
        "soramitsukhmer-lab/vault:${VAULT_VERSION}-dev"
    ]
}

target "release" {
    inherits = ["vault"]
    platforms = [
        "linux/amd64",
        "linux/arm64"
    ]
    tags = [
        "harbor.sorakh.io/soramitsukhmer-lab/vault:${VAULT_VERSION}"
    ]
}
