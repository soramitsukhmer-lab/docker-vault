variable "VAULT_VERSION" { default = "1.17.6" }

target "docker-metadata-action" {}

target "vault" {
    inherits = ["docker-metadata-action"]
    args = {
        VAULT_VERSION = "${VAULT_VERSION}"
    }
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
