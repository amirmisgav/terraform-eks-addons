

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
}

variable "env_name" {
  type        = string
  description = "Environment name"
}

variable "vpc_id" {
  type        = string
  description = "The clusters VPC id"
}

variable "spot_enabled" {
  type        = bool
  description = "Is the node group working on Spot servers"
  default     = true
}

variable "aws_region" {
  type    = string
  default = "The region where the EKS cluster is deployed"
}
