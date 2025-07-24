target "docker-metadata-action" {}

target "default" {
    inherits = ["docker-metadata-action"]
    args = {
        GO_VERSION = "1.24.3"
        NODE_VERSION = "20"
        VAULT_VERSION = "1.20.0"
    }
    tags = [
        "harbor.sorakh.io/soramitsukhmer-lab/vault:1.20.0-dev"
    ]
}
