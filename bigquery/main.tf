

resource "google_bigquery_dataset" "dataset" {
  for_each                    = toset(var.dataset_id)
  dataset_id                  = each.key
  friendly_name               = each.key
  description                 = "This is a bigquery description"
  location                    = "EU"
  default_table_expiration_ms = 3600000
 
  access {
  role          = "OWNER"
  user_by_email = var.service_account_authorized_access_bigquery
}
}

