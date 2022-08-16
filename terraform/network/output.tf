output "out_gehad-vpc_name" {
    value = google_compute_network.gehad-vpc.name
}

output "out_subnet_id" {
    value = google_compute_subnetwork.gehad_subnet.id
}
output "out_subnet_name" {
    value = google_compute_subnetwork.gehad_subnet.name
}
