
provider "kubernetes" {
  host                   = data.google_container_cluster.primary.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.primary.master_auth[0].cluster_ca_certificate)
}

data "google_client_config" "default" {}

data "google_container_cluster" "primary" {
  name     = "shortletapp-time-api-cluster"
  location = "us-east4"
}


resource "kubernetes_deployment" "time_api" {
  metadata {
    name = "time-api"
    labels = {
      app = "time-api"
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "time-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "time-api"
        }
      }

      spec {
        container {
          image = "gcr.io/corded-evening-434319-k3/time-api:v1"
          name  = "time-api"

          port {
            container_port = 9792
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "time_api_service" {
  metadata {
    name = "time-api-service"
  }

  spec {
    selector = {
      app = "time-api"
    }

    port {
      port        = 80
      target_port = 9792
    }

    type = "LoadBalancer"
  }
}
