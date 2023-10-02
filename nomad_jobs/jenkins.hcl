job "jenkins" {
    datacenters = ["dc1"]

    group "jenkins" {
        network {
            port "http" {
                static = 8080
            }
        }

        task "jenkins" {
            driver = "docker"

            service {
                name = "jenkins-service"
                port = "http"
                provider = "nomad"
                address_mode = "driver"
            }

            config {
                image = "jenkins:demo"
                ports = ["http"]
                volumes = [
                    "local/jenkins:/var/jenkins_home"
                ]
            }

            resources {
                memory = 2048  # 2GB of memory
            }
        }
    }
}