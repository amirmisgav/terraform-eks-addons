resource "kubernetes_namespace" "env" {
  metadata {
    name = var.env_name
    labels = {
      name = var.env_name
    }
  }
  depends_on = [
    data.aws_eks_cluster.this
  ]
}

resource "kubernetes_namespace" "operations" {
  metadata {
    name = "operations"
    labels = {
      name = "operations"
    }
  }
  depends_on = [
    data.aws_eks_cluster.this
  ]
}

# create amazon namespace
resource "kubernetes_namespace" "amazon" {
  metadata {
    name = "amazon"
    labels = {
      name = "amazon"
    }
  }
  depends_on = [
    data.aws_eks_cluster.this
  ]
}

# create metrics namespace
resource "kubernetes_namespace" "metrics" {
  metadata {
    name = "metrics"
    labels = {
      name = "metrics"
    }
  }
  depends_on = [
    data.aws_eks_cluster.this
  ]
}

# create ArgoCD namespace
resource "kubernetes_namespace" "argocd" {
  count = var.argocd_enabled ? 1 : 0
  metadata {
    name = "argocd"
    labels = {
      name = "argocd"
    }
  }
  depends_on = [
    data.aws_eks_cluster.this
  ]
}
