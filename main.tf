terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "docker" {}

# Prometheus Image
resource "docker_image" "prometheus" {
  name = "prom/prometheus:latest"
}

# Grafana Image
resource "docker_image" "grafana" {
  name = "grafana/grafana:latest"
}

# Node Exporter Image
resource "docker_image" "node_exporter" {
  name = "prom/node-exporter:latest"
}

# Prometheus Container
resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = "prom/prometheus:latest"  

  ports {
    internal = 9090
    external = 9090
  }

  volumes {
    host_path      = "E:\\wisdom\\monitoring\\prometheus.yml"  # Path to your Prometheus config
    container_path = "/etc/prometheus/prometheus.yml"
  }
}

# Grafana Container
resource "docker_container" "grafana" {
  name  = "grafana"
  image = "grafana/grafana:latest"

  ports {
    internal = 3000
    external = 3000
  }
   env = [
    "GF_SMTP_ENABLED=true",
    "GF_SMTP_HOST=smtp.gmail.com:587",
    "GF_SMTP_USER=adityaskarad@gmail.com",
    "GF_SMTP_PASSWORD=jzbn oavg wkmb olcx",
    "GF_SMTP_FROM_ADDRESS=adityaskarad@gmail.com",
    "GF_SMTP_FROM_NAME=Grafana",
    "GF_SMTP_SKIP_VERIFY=true"
  ]
}

# Node Exporter Container
resource "docker_container" "node_exporter" {
  name  = "node_exporter"
  image = "prom/node-exporter:latest"

  ports {
    internal = 9100
    external = 9100
  }
}
