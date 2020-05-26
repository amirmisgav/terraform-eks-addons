variable "env_name" {
  type        = string
  description = "The name of the env"
}

variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "vpc_id" {
  description = "VPC where the cluster and workers will be deployed."
  type        = string
}

variable "spot_enabled" {
  type        = bool
  default     = true
  description = "Is the cluster using spot instances?"
}

variable "kube2iam_enabled" {
  type        = bool
  default     = true
  description = "if kube2iam should be installed?"
}

variable "aws_cluster_autoscaler_enabled" {
  type        = bool
  default     = true
  description = "if cluster autoscaler should be installed?"
}

variable "argocd_enabled" {
  type        = bool
  description = "if ArgoCD should be added to the cluster"
}

variable "external_secrets_enabled" {
  type        = bool
  default     = true
  description = "Kubernetes External Secrets allows you to use external secret management systems (e.g., AWS Secrets Manager)"
}

variable "aws_region" {
  description = "The Region where the cluster is be deployed."
  type        = string
}
