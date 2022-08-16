output "out_vpc_name" {
    value = google_compute_network.vpc.name
}

output "out_subnet_id" {
    value = google_compute_subnetwork.subnet.id
}
output "out_subnet_name" {
    value = google_compute_subnetwork.subnet.name
}
