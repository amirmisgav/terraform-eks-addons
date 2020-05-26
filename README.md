## Requirements

| Name | Version |
|------|---------|
| aws | 2.63 |

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cluster\_name | Name of the EKS cluster | `string` | n/a | yes |
| env\_name | Environemt name | `string` | n/a | yes |
| spot\_enabled | Is the node group working on Spot servers | `bool` | `true` | no |
| vpc\_id | The clusters VPC id | `string` | n/a | yes |

## Outputs

No output.
