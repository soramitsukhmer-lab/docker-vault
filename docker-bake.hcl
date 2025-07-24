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
