job "vault" {
    datacenters = ["dc1"]

    group "vault" {
        network {
            port "http" {
                static = 8200
            }
        }

        task "vault" {
            driver = "docker"

            service {
                name = "vault-service"
                port = "http"
                provider = "nomad"
                address_mode = "driver"
            }

            config {
                image = "vault:1.13.3"
                ports = ["http"]
            }

            env {
                VAULT_DEV_ROOT_TOKEN_ID = "myroot"
            }

            resources {
                memory = 1024
            }
        }
    }
}