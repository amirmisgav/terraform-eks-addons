//# Install fluentd-cloudwatch
//resource "helm_release" "fluentd_cloudwatch" {
//  depends_on = [
//    kubernetes_namespace.amazon
//  ]
//
//  name       = "fluentd-cloudwatch"
//  chart      = "fluentd-cloudwatch"
//  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
//  namespace  = "amazon"
//  version    = "0.12.0"
//
//  set {
//    name  = "awsRegion"
//    value = data.aws_region.current.name
//  }
//
//  set {
//    name  = "logGroupName"
//    value = "/aws/eks/${var.cluster_name}/application"
//  }
//
//  set {
//    name  = "rbac.create"
//    value = true
//  }
//
//  set {
//    name  = "rbac.serviceAccountName"
//    value = "fluentd-cloudwatch"
//  }
//
//  set {
//    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
//    value = aws_iam_role.fluentd_cloudwatch.arn
//  }
//}

// Install cloudwatch-agent
resource "helm_release" "cloudwatch_agent" {
  depends_on = [
    kubernetes_namespace.amazon
  ]

  name       = "cloudwatch-agent"
  namespace  = "amazon"
  chart      = "cloudwatch-agent"
  repository = format("%s/charts", path.module)
  version    = "0.1.0"

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  set {
    name  = "eksClusterName"
    value = var.cluster_name
  }

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "rbac.serviceAccountName"
    value = "cloudwatch-agent"
  }

  set {
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.cloudwatch_agent.arn
  }
}

// Install metrics-server
resource "helm_release" "metrics_server" {
  depends_on = [
    kubernetes_namespace.metrics
  ]
  name       = "metrics-server"
  chart      = "metrics-server"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  namespace  = "metrics"
  version    = "2.8.7"
}

// Install aws-alb-ingress-controller
resource "helm_release" "aws_alb_ingress_controller" {

  name       = "aws-alb-ingress-controller"
  chart      = "aws-alb-ingress-controller"
  repository = "https://kubernetes-charts-incubator.storage.googleapis.com"
  namespace  = "kube-system"
  version    = "0.1.11"

  set {
    name  = "clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  set {
    name  = "awsVpcID"
    value = var.vpc_id
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccountName"
    value = "aws-alb-ingress-controller"
  }

  set {
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.aws_alb_ingress_controller.arn
  }
}

// Install external-dns
resource "helm_release" "external_dns" {

  name       = "external-dns"
  chart      = "external-dns"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  namespace  = "kube-system"
  version    = "2.19.1"
  timeout    = 60

  set {
    name  = "image.pullPolicy"
    value = "Always"
  }

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "policy"
    value = "upsert-only"
  }

  set {
    name  = "rbac.create"
    value = "true"
  }

  set {
    name  = "rbac.serviceAccountName"
    value = "external-dns"
  }

  set {
    name  = "rbac.serviceAccountAnnotations.eks\\.amazonaws\\.com/role-arn"
    value = aws_iam_role.external_dns.arn
  }

  set {
    name  = "aws.zoneType"
    value = "public"
  }
}

// Install ec2 node Autoscaler
resource "helm_release" "cluster_autoscaler" {
  count      = var.aws_cluster_autoscaler_enabled ? 1 : 0
  name       = "aws-cluster-autoscaler"
  chart      = "cluster-autoscaler"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  namespace  = "kube-system"
  timeout    = 600

  set {
    name  = "autoDiscovery.clusterName"
    value = var.cluster_name
  }

  set {
    name  = "awsRegion"
    value = data.aws_region.current.name
  }

  set {
    name  = "cloudProvider"
    value = "aws"
  }

  set {
    name  = "expander"
    value = "least-waste"
  }

  set {
    name  = "rbac.create"
    value = true
  }
}

// Install k8s-spot-termination-handler
resource "helm_release" "k8s-spot-termination-handler" {
  count      = var.spot_enabled ? 1 : 0
  name       = "k8s-spot-termination-handler"
  chart      = "k8s-spot-termination-handler"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  namespace  = "kube-system"
  timeout    = 60

  set {
    name  = "clusterName"
    value = var.cluster_name
  }
}

// Install external_secrets
resource "helm_release" "external_secrets" {
  count      = var.external_secrets_enabled ? 1 : 0
  name       = "kubernetes-external-secrets"
  chart      = "kubernetes-external-secrets"
  repository = "https://godaddy.github.io/kubernetes-external-secrets"
  namespace  = "kube-system"
  timeout    = 60

  set {
    name  = "env.AWS_REGION"
    value = data.aws_region.current.name
  }

  set {
    name  = "env.POLLER_INTERVAL_MILLISECONDS"
    value = "300000"
  }
}

// Install kube2iam
resource "helm_release" "kube2iam" {
  count      = var.kube2iam_enabled ? 1 : 0
  name       = "kube2iam"
  chart      = "kube2iam"
  repository = "https://kubernetes-charts.storage.googleapis.com"
  namespace  = "kube-system"
  timeout    = 60

  set {
    name  = "auto-discover-base-arn"
    value = ""
  }

  set {
    name  = "auto-discover-default-role"
    value = ""
  }

  set {
    name  = "host.iptables"
    value = true
  }

  set {
    name  = "rbac.create"
    value = true
  }
  set {
    name  = "host.interface"
    value = "eni+"
  }
  set {
    name  = "verbose"
    value = true
  }
}

// Install argocd
resource "null_resource" "argocd" {
  count = var.argocd_enabled ? 1 : 0

  provisioner "local-exec" {
    command = "kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml"
  }

  depends_on = [
    kubernetes_namespace.argocd
  ]
}
