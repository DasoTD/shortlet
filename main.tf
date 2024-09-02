provider "google" {
  project = var.project_id
  region  = "us-east4"
}

resource "google_container_cluster" "primary" {
  name     = "shortletapp-time-api-cluster"
  location = "us-east4"

  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
    disk_size_gb = 20
  }
  deletion_protection = false
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-pool"
  cluster    = google_container_cluster.primary.name
  location   = google_container_cluster.primary.location
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-medium"
    

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

output "kubernetes_cluster_name" {
  value = google_container_cluster.primary.name
}
