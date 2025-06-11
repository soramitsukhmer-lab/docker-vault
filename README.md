## About

This repository is used to build the container image for [soramitsukhmer-lab/vault#builtin/logical/transit/ed25519sha3](https://github.com/soramitsukhmer-lab/vault/tree/builtin/logical/transit/ed25519sha3).

Example configuration file for Vault:
```hcl
ui            = true
cluster_addr  = "http://127.0.0.1:8201"
api_addr      = "http://127.0.0.1:8200"

storage "file" {
  path = "/vault/file"
}

// The "iroha-transit" is available in the plugin directory.
plugin_directory = "/vault/plugins"
```
