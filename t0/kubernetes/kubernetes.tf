variable "gcp_project" {
  type = "string"
}

variable "gcp_cluster_pw" {
  type = "string"
}

provider "google" {
  project     = "${var.gcp_project}"
  region      = "europe-west2"
}

resource "google_container_cluster" "primary" {
  name               = "test-cluster"
  zone               = "europe-west2-a"
  initial_node_count = 1

  master_auth {
    username = "sviojs"
    password = "${var.gcp_cluster_pw}"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

# gcp users just need cluster name + zone to be able to set creds through gcloud
output "cluster_name" {
  value = "${google_container_cluster.primary.id}"
}

output "cluster_zone" {
  value = "${google_container_cluster.primary.zone}"
}

# The following outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  sensitive = true
  value = "${google_container_cluster.primary.master_auth.0.client_certificate}"
}

output "client_key" {
  sensitive = true
  value = "${google_container_cluster.primary.master_auth.0.client_key}"
}

output "username" {
  value = "${google_container_cluster.primary.master_auth.0.username}"
}

output "password" {
  sensitive = true
  value = "${google_container_cluster.primary.master_auth.0.password}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.primary.master_auth.0.cluster_ca_certificate}"
}

output "cluster_api_url" {
  value = "${google_container_cluster.primary.endpoint}"
}
