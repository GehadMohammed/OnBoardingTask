# private cluster mean you can not access the control plan from public ip but it still can expose application and pods using loadbalancer
#########
#The control plane runs on a virtual machine (VM) that is in a gehad-vpc network in a Google-owned project. 
#In private clusters, the control plane's gehad-vpc network is connected to your cluster's gehad-vpc network with gehad-vpc Network Peering. 
#Your gehad-vpc network contains the cluster nodes, and the Google-owned Google Cloud gehad-vpc network contains your cluster's control plane.
##########
#Private endpoint
# The private endpoint is an internal IP address in the control plane's gehad-vpc network.
# In a private cluster, nodes always communicate with the control plane's private endpoint.
# Depending on your configuration,
# you can manage the cluster with tools like kubectl that connect to the private endpoint as well.
# Any VM that uses the same subnet that your private cluster uses can also access the private endpoint.

resource "google_container_cluster" "gehad-gke" {
  name= var.Cluster_name
  #  The location (region or zone) in which the cluster master will be created,
  # as well as the default node location. If you specify a zone (such as us-central1-a), 
  # the cluster will be a zonal cluster with a single cluster master. 
  # If you specify a region (such as us-west1), 
  # the cluster will be a regional cluster with multiple masters spread across zones in the region,
  #  and with default node locations in those zones as well
   location     = "${var.cluster_region}-b"
 

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  # must create at least one y defult node then delete it
  initial_node_count       = 1
  # worker node location
  node_locations           =["${var.cluster_region}-c"]

  # gehad-vpc subnet cluster will created 
  network = var.gehad-vpc
  subnetwork = var.subnet
  
# option  needed when create pricvate cluster
 private_cluster_config {

    #A private endpoint is a network interface that uses a private IP address from your virtual network.
    # This network interface connects you privately and securely to a service
    #--enable-private-endpoint indicates that the cluster is managed using the private IP address of the control plane API endpoint.
    enable_private_endpoint = true
    #indicates that the cluster's nodes do not have external IP addresses.
    enable_private_nodes    = true
    # subnet for gcp gehad-vpc master node created in , 192.168.1.0/28
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
  
# who can access cluster "run kubctl"

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = var.authorized_network_cidr
      display_name = "authorized_network"
    }
  }
  #googleapi: Error 400: Alias IP addresses are required for private cluster, please make sure you enable alias IPs when creating a cluster., badRequest
networking_mode ="VPC_NATIVE"
#Error: `ip_allocation_policy` block is required for gehad-vpc_NATIVE clusters.
  #pod w service ips  https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips
ip_allocation_policy {
    # cluster_ipv4_cidr_block = var.pods_ipv4_cidr_block
    # services_ipv4_cidr_block = var.services_ipv4_cidr_block
  }

  cluster_autoscaling {
    enabled = false
  }

}

resource "google_container_node_pool" "app_cluster_node_pool" {
  name           = "${google_container_cluster.gehad-gke.name}-node-pool"
  location       = google_container_cluster.gehad-gke.location
  #node_locations = ["${var.cluster_region}-b"]
  cluster        = google_container_cluster.gehad-gke.name
  #it's inform cluster create 2 worker node in each zone
  node_count     = var.Number_of_nodes_per_zone

  
  node_config {
    # 
    preemptible  = true
    # The Google Cloud Platform Service Account to be used by the node pool VMs
    service_account = var.service_account
    machine_type = var.machine_type
    image_type = var.image_type
    disk_size_gb = var.disk_size_gb
    disk_type = var.disk_type


    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]

  }

  depends_on = [
    google_container_cluster.gehad-gke
  ]
 
}


##links
##https://thoeny.dev/create-a-private-gcp-kubernetes-cluster-using-terraform
## https://cloud.google.com/kubernetes-engine/docs/how-to/private-clusters#req_res_lim
##https://cloud.google.com/kubernetes-engine/docs/concepts/alias-ips
## https://cloud.google.com/sdk/gcloud/reference/auth/activate-service-account
