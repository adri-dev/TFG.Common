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
  default = "tfg-k8s"
}

variable "storage_account_name" {
  default = "tfgterraformst"
}

variable "ARM_CLIENT_ID" {
  sensitive = true
}

variable "ARM_CLIENT_SECRET" {
  sensitive = true
}

variable "SQL_USER" {
  sensitive = true
}

variable "SQL_PASSWORD" {
  sensitive = true
}