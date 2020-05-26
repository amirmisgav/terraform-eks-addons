## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.6 |
| aws | 2.52 |

## Providers

| Name | Version |
|------|---------|
| aws | 2.52 |
| helm | n/a |
| kubernetes | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| argocd\_enabled | if ArgoCD should be added to the cluster | `bool` | n/a | yes |
| aws\_cluster\_autoscaler\_enabled | if cluster autoscaler should be installed? | `bool` | `true` | no |
| aws\_region | The Region where the cluster is be deployed. | `string` | n/a | yes |
| cluster\_name | The name of the EKS cluster. | `string` | n/a | yes |
| env\_name | The name of the env | `string` | n/a | yes |
| external\_secrets\_enabled | Kubernetes External Secrets allows you to use external secret management systems (e.g., AWS Secrets Manager) | `bool` | `true` | no |
| kube2iam\_enabled | if kube2iam should be installed? | `bool` | `true` | no |
| spot\_enabled | Is the cluster using spot instances? | `bool` | `true` | no |
| vpc\_id | VPC where the cluster and workers will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aws\_alb\_ingress\_controller\_helm\_release\_metadata | Block status of the deployed aws-alb-ingress-controller helm release. |
| cloudwatch\_agent\_helm\_release\_metadata | Block status of the deployed fluentd-cloudwatch helm release. |
| external\_dns\_helm\_release\_metadata | Block status of the deployed external-dns helm release. |
