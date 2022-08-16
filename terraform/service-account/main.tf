resource "google_service_account" "service_account" {
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_project_iam_member" "project" {
  project = var.project-id
  role    = var.service_account_role
  member  = "serviceAccount:${google_service_account.service_account.email}"
}


#gcloud auth activate-service-account terraform-service-account@iti-2-358616.iam.gserviceaccount.com --key-file=iti-2-358616-786f67cb34ba.json