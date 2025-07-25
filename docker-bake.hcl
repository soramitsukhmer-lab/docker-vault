variable "MATRIX_VERSIONS" {
  type = list(string)
  default = [
    "1.17.6",
    "1.20.0",
  ]
}

target "default" {
  matrix = {
    version = MATRIX_VERSIONS
  }
  name = "vault_${replace(version, ".", "_")}"
  context = "v${version}"
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  tags = [
      "harbor.sorakh.io/soramitsukhmer-lab/vault:${version}"
  ]
}

target "dev" {
  matrix = {
    version = MATRIX_VERSIONS
  }
  name = "vault_${replace(version, ".", "_")}_dev"
  context = "v${version}"
  tags = [
      "harbor.sorakh.io/soramitsukhmer-lab/vault:${version}-dev"
  ]
}
