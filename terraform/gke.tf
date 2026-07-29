#master
resource "google_container_cluster" "primary" {
  name      = "nexus-gke-cluster"
  location  = var.zone

  remove_default_node_pool  = true
  initial_node_count        = 1
}

#node-pool
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name        = "nexus-node-pool"
  location    = var.zone
  cluster     = google_container_cluster.primary.name
  node_count  = 1

  node_config {
    preemptible   = true
    machine_type  = "n1-standard-1"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
