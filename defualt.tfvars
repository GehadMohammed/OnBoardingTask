project-id                 = "iti-2-358616"                   
# vm service account
vm-account_id                 = "vm-service-account"
vm-display_name               = "vm service account"
vm-service_account_role       = "roles/container.admin"

# node-pool service account
node-pool-account_id                 = "node-pool-service-account"
node-pool-display_name               = "node-pool service account"
node-pool-service_account_role       = "roles/storage.objectViewer"


# network module varibale
vpc_name                   = "gehad-gehad-vpc"
subnet_name                = "gehad-subnet"
subnet_cidr                = "10.0.1.0/24"


# compute engin module varibal

VM_Machine_name            = "gehadt-test-vm"
VM_Machine_type            = "e2-micro"
VM_OS_image                = "ubuntu-os-cloud/ubuntu-2204-lts"
VM_Zone                    = "europe-west1-b"

# gs bucket module variable

gsbucket_name              = "gehad_bucket"
storage_class              = "STANDARD"
bucketserviceAccountRole =   "roles/storage.objectViewer"

# bigquery module variable

dataset_id                 = "gehad_bigquery"


# gcr module var
gcr-location               = "EU"


# kubernetes cluster module varibale
Cluster_name               = "gehad-cluster"
cluster_region             = "europe-west1"
master_ipv4_cidr_block     = "192.168.1.0/28"
Number_of_nodes_per_zone   =  1
machine_type               = "g1-small"
image_type                 = "COS_CONTAINERD"
disk_size_gb               = "10"
disk_type                  = "pd-standard"
