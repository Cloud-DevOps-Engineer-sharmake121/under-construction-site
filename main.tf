provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "website" {
  name     = "${var.project_id}-website"
  location = var.region
  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
}

resource "google_storage_bucket_object" "index" {
  name         = "index.html"
  bucket       = google_storage_bucket.website.name
  source       = "index.html"
  content_type = "text/html"
}

resource "google_storage_bucket_iam_member" "public" {
  bucket = google_storage_bucket.website.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}
