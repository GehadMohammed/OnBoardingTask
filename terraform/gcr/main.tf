#A private container image registry that supports Docker Image Manifest V2 and OCI image formats.
# It provides a subset of Artifact Registry features.

#Ensures that the Google Cloud Storage bucket that backs Google Container Registry exists.
#Creating this resource will create the backing bucket if it does not exist, or do nothing if the bucket already exists.

resource "google_container_registry" "registry" {
  project  = var.project-id
  location = var.gcr-location
}
