target "default" {
  matrix = {
    version = [
      "1.17.6",
      "1.20.0",
    ]
  }
  name = "vault_${replace(version, ".", "_")}"
  context = "v${version}"
  tags = [
      "harbor.sorakh.io/soramitsukhmer-lab/vault:${version}-dev"
  ]
}
