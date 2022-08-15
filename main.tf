module "network" {
    source = "./network"

    gehad-vpc_name = var.gehad-vpc_name
    subnet_name = var.subnet_name
    subnet_cidr = var.subnet_cidr
 
}

module "service-account-vm" {
  source = "./service-account"
  account_id                 = var.vm-account_id
  display_name               = var.vm-display_name
  project-id                 = var.project-id
  service_account_role       = var.vm-service_account_role

}


module "service-account-node-pool" {
  source = "./service-account"
  account_id                 = var.node-pool-account_id
  display_name               = var.node-pool-display_name
  project-id                 = var.project-id
  service_account_role       = var.node-pool-service_account_role

}

module "compute_engine" {
  source = "./compute_engine"

  VM_Machine_name            = var.VM_Machine_name
  VM_Machine_type            = var.VM_Machine_type
  VM_OS_image                = var.VM_OS_image
  VM_Zone                    = var.VM_Zone
  VM_network                 = "${module.network.out_gehad-vpc_name}"
  VM_subnetwork              = "${module.network.out_subnet_id}"
  service_account_email      = "${module.service-account-vm.service_account_email}"

}

module "gsbucket" {

  source = "./gsbucket"
  gsbucket_name             = ["gsbucket_1","gsbucket_2","gsbucket_3"]
  storage_class             = var.storage_class
  bucketserviceAccountRole   = var.bucketserviceAccountRole
  serviceAccountemail       = "${module.service-account-vm.service_account_email}"
   depends_on = [
    module.service-account-vm
  ]
}


module "bigquery" {
  source                   ="./bigquery"
  dataset_id                  = ["bigquery_1","bigquery_2","bigquery_3"]
  service_account_authorized_access_bigquery = "${module.service-account-vm.service_account_email}"

}

module "gcr" {
  source = "./gcr"
  project-id   = var.project-id
  gcr-location  = var.gcr-location
  
}

 module "kubernetes_cluster" {
  source = "./kubernetes_cluster"

  Cluster_name               = var.Cluster_name
  cluster_region             = var.cluster_region
  gehad-vpc                        = "${module.network.out_gehad-vpc_name}"
  subnet                     = "${module.network.out_subnet_name}"
  master_ipv4_cidr_block     = var.master_ipv4_cidr_block
  authorized_network_cidr    = var.subnet_cidr
  Number_of_nodes_per_zone   =  var.Number_of_nodes_per_zone
  service_account            = "${module.service-account-vm.service_account_email}"
  machine_type               = var.machine_type
  image_type                 = var.image_type
  disk_size_gb               = var.disk_size_gb
  disk_type                  = var.disk_type

  
 }

