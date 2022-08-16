
resource "google_compute_network" "gehad-vpc" {
  name                    = var.gehad-vpc_name
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.gehad-vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"] 
  }
  source_ranges = ["35.235.240.0/20"]
}

resource "google_compute_subnetwork" "gehad_subnet" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.gehad-vpc.id
  private_ip_google_access = true
}


resource "google_compute_router" "router" {
  name    = "gehad-router"
  region  = google_compute_subnetwork.gehad_subnet.region
  network = google_compute_network.gehad-vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}