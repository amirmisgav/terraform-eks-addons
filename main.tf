
module "addons" {
  source           = "./modules/eks-addons"
  cluster_name     = var.cluster_name
  env_name         = var.env_name
  vpc_id           = var.vpc_id
  spot_enabled     = var.spot_enabled
  argocd_enabled   = true
  kube2iam_enabled = false
}
