target "docker-metadata-action" {}

target "default" {
    inherits = ["docker-metadata-action"]
    args = {
        VAULT_VERSION = "1.17.6"
    }
    tags = [
        "harbor.sorakh.io/soramitsukhmer-lab/vault:1.17.6-dev"
    ]
}
