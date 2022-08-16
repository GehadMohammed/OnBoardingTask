variable "project-id" {
  type = string
}

# vm service account

variable "vm-account_id" {
   type = string
}
variable "vm-display_name" {
   type = string
}

variable "vm-service_account_role" {
  type = string
}

# node pool service account

variable "node-pool-account_id" {
   type = string
}
variable "node-pool-display_name" {
   type = string
}

variable "node-pool-service_account_role" {
  type = string
}
# vm 
variable "gehad-vpc_name" {
  type = string  
}

variable "subnet_name" {
  type = string
}

variable "subnet_cidr" {
  type = string

}
#

variable "VM_Machine_name" {
  type = string
  
}
variable "VM_Machine_type" {
  type = string
  
}
variable "VM_OS_image" {
  type = string
}


variable "VM_Zone" {
   type = string
}




########## gsbucket

variable "gsbucket_name" {
  type = string
}

variable "storage_class" {
  type = string
}

variable "bucketserviceAccountRole" {
  type = string
}


## bigquery

variable "dataset_id" {
  type = string
  
}


## gcr

variable "gcr-location" {
  type = string
}

#gke

variable "Cluster_name" {
  type = string
  
}

variable "master_zone" {
  type = string  
}

variable "worker_node_zone" {
  type = string  
}

variable "master_ipv4_cidr_block" {
 type = string 
}


variable "Number_of_nodes_per_zone" {
  type = number

}

variable "machine_type" {
    type = string
}

variable "image_type" {
    type = string
}

variable "disk_size_gb" {
   type = string 
}

variable "disk_type" {
   type = string 
}
