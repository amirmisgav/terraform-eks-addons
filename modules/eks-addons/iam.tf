# Associate IAM oidc provider
resource "aws_iam_openid_connect_provider" "this" {
  depends_on = [data.aws_eks_cluster.this]
  client_id_list = [
    "sts.amazonaws.com"
  ]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = data.aws_eks_cluster.this.identity.0.oidc.0.issuer
}

#  IAM role for fluentd-cloudwatch service account
resource "aws_iam_role" "fluentd_cloudwatch" {
  name               = "${var.cluster_name}-fluentd-cloudwatch-sa"
  assume_role_policy = data.aws_iam_policy_document.fluentd_cloudwatch_role_policy.json
}

resource "aws_iam_role_policy_attachment" "fluentd_cloudwatch" {
  role       = aws_iam_role.fluentd_cloudwatch.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

#  IAM role for cloudwatch-agent service account
resource "aws_iam_role" "cloudwatch_agent" {
  name               = "${var.cluster_name}-cloudwatch-agent-sa"
  assume_role_policy = data.aws_iam_policy_document.cloudwatch_agent_role_policy.json
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.cloudwatch_agent.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

#  IAM role for aws-alb-ingress-controller service account
resource "aws_iam_role" "aws_alb_ingress_controller" {
  name               = "${var.cluster_name}-aws-alb-ingress-controller-sa"
  assume_role_policy = data.aws_iam_policy_document.aws_alb_ingress_controller_role_policy.json
}

# IAM policy for aws-alb-ingress-controller role
resource "aws_iam_role_policy" "aws_alb_ingress_controller" {
  name = "${var.cluster_name}-aws-alb-ingress-controller-sa"
  role = aws_iam_role.aws_alb_ingress_controller.id

  policy = data.aws_iam_policy_document.aws_alb_ingress_controller.json
}



#  IAM role for external dns service account
resource "aws_iam_role" "external_dns" {
  name               = "${var.cluster_name}-external-dns-sa"
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume_role_policy.json
}

# IAM policy for external dns role
resource "aws_iam_role_policy" "external_dns" {
  name = "${var.cluster_name}-external-dns-sa"
  role = aws_iam_role.external_dns.id

  policy = data.aws_iam_policy_document.external_dns.json
}
