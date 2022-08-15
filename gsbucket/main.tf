resource "google_storage_bucket" "gehad-gsbucket" {
  for_each      = toset(var.gsbucket_name)
  name          = each.key
  location      = "EU"
  force_destroy = true
  storage_class      = var.storage_class
  uniform_bucket_level_access = true

}

resource "google_storage_bucket_iam_member" "binding" {
  for_each      = toset(var.gsbucket_name)
  bucket        = each.key
  role          = var.bucketserviceAccountRole
  member        = "serviceAccount:${var.serviceAccountemail}"
  depends_on = [
    google_storage_bucket.gehad-gsbucket
  ]
}
