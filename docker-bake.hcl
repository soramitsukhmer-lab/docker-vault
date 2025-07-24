target "v1_17" {
    inherits = [ "v1_17_6" ]
}
target "v1_17_6" {
    inherits = [ "vault-plugin-catalog" ]
    context = "v1.17.6"
    args = {
        VAULT_VERSION = "1.17.6"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64"
    ]
    tags = [
        "harbor.sorakh.io/soramitsukhmer-lab/vault:1.17.6"
    ]
}

target "v1_20" {
    inherits = [ "v1_20_0" ]
}
target "v1_20_0" {
    inherits = [ "vault-plugin-catalog" ]
    context = "v1.20.0"
    args = {
        VAULT_VERSION = "1.20.0"
        GO_VERSION = "1.24.3"
        NODE_VERSION = "20"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64"
    ]
    tags = [
        "harbor.sorakh.io/soramitsukhmer-lab/vault:1.20.0"
    ]
}

target "vault-plugin-catalog" {
  args = {
    VAULT_PLUGIN_CATALOG_VERSION = "0.1.0-rc.11"
  }
}
