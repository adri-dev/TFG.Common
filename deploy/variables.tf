variable "agent_count" {
  default = 1
}

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}

variable "dns_prefix" {
  default = "k8stest"
}

variable "cluster_name" {
  default = "tfgk8s"
}

variable "resource_group_name" {
  default = "tfg-k8s-rg"
}

variable "ARM_CLIENT_ID" {
  sensitive = true
}

variable "ARM_CLIENT_SECRET" {
  sensitive = true
}