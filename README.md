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

Register `iroha-transit` secret plugin:
```bash
export VAULT_ADDR=http://localhost:8200
export VAULT_TOKEN=token

# Download or update plugin catalog
vault-plugin-catalog update

# List available plugins
vault-plugin-catalog list

# Download and install the plugin to appropriate directory
vault-plugin-catalog install iroha-transit-demo

# This will not register the plugin to Vault but will print all necessary command to register the plugin
vault-plugin-catalog register iroha-transit-demo
```

The plugin release can be found on [soramitsukhmer-lab/poc-vault-iroha-integration](https://github.com/soramitsukhmer-lab/poc-vault-iroha-integration) release page.
