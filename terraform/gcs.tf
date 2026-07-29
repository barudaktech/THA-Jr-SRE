resource "google_storage_bucket" "nexus_blobstore" {
  name          = "${var.project_id}-nexus-blobstore"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}
