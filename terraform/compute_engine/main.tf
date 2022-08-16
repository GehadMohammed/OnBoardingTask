
resource "google_compute_instance" "test-vm" {
  name         = var.VM_Machine_name
  machine_type = var.VM_Machine_type
  zone         = var.VM_Zone
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = var.VM_OS_image
      type = "pd-standard"
      size = 10
    }
  }

  network_interface {
    network = var.VM_network
    subnetwork = var.VM_subnetwork
  }
 
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.

    service_account {
    email = var.service_account_email
    #l service accoubt hyb2a sha3'al 3ala anhy api , kol service leha api , "cloud-platform" scop for all api 
    # bs kda kda l sa ma7kom be l role l adthalo
    #scopes - (Required) A list of service scopes. Both OAuth2 URLs and gcloud short names are supported.
    # To allow full access to all Cloud APIs, use the cloud-platform scope
 
    scopes = [ "cloud-platform" ]
  }
 

}
