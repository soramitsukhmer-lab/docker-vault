target "docker-metadata-action" {}

target "default" {
    inherits = ["docker-metadata-action"]
    args = {
        ALPINE_VERSION = "3.13"
        GO_VERSION = "1.24.3"
        NODE_VERSION = "18.20.7"
        # VAULT_VERSION = "1.19.0"
    }
    tags = [
        "localhost/vault:dev"
    ]
}

target "dev" {
    inherits = ["docker-metadata-action"]
    args = {
        ALPINE_VERSION = "3.13"
        GO_VERSION = "1.24.3"
        NODE_VERSION = "18.20.7"
        # VAULT_VERSION = "1.19.0"
        # DOCKER_META_VERSION = "1.19.0-dev"
    }
    tags = [
        "localhost/vault:dev"
    ]
}
