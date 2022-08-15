
variable "Cluster_name" {
  type = string
  
}

variable "cluster_region" {
  type = string  
}

variable "gehad-vpc" {
  type= string

}
variable "subnet" {
  type= string

}

variable "master_ipv4_cidr_block" {
 type = string 
}

variable "authorized_network_cidr" {
  type= string
}

variable "Number_of_nodes_per_zone" {
  type = number

}

variable "service_account" {
    type = string
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
