variable "MATRIX_VERSIONS" {
  type = list(string)
  default = [
    "1.17.6",
    "1.20.0",
  ]
}

variable "GITHUB_REPOSITORY_OWNER" {
  default = "soramitsukhmer-lab"
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
      "ghcr.io/${GITHUB_REPOSITORY_OWNER}/vault:${version}"
  ]
}

target "dev" {
  matrix = {
    version = MATRIX_VERSIONS
  }
  name = "vault_${replace(version, ".", "_")}_dev"
  context = "v${version}"
  tags = [
      "ghcr.io/${GITHUB_REPOSITORY_OWNER}/vault:${version}-dev"
  ]
}
