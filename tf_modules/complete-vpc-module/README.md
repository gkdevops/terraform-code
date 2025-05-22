# AWS VPC Terraform Module

This Terraform module (`aws-vpc-code`) provisions a customizable AWS Virtual Private Cloud (VPC) network, including public and private subnets, route tables, security groups, a NAT gateway, and other essential networking components.

## Features

- Creates a VPC with DNS support and hostnames enabled.
- Configures public and private subnets (default: 2 of each, across availability zones).
- Sets up route tables for public and private subnets.
- Deploys an Internet Gateway and optionally a NAT Gateway.
- Creates security groups with customizable ingress rules.
- Outputs subnet IDs, VPC ID, security group IDs, and availability zones.

## Usage

```hcl
module "vpc" {
  source        = "./aws-vpc-code"
  vpc_cidr      = "10.1.0.0/16"
  public_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
  aws_region    = "us-east-1"
  ingress_ports = [22, 8080]
}
```

## Input Variables

| Name           | Description                                              | Type           | Default                     |
|----------------|----------------------------------------------------------|----------------|-----------------------------|
| tag_name       | The tag name to associate with resources                 | `string`       | `"1.0.0"`                   |
| aws_region     | AWS region to create resources in                        | `string`       | `"us-east-1"`               |
| vpc_cidr       | CIDR block for the VPC                                   | `string`       | `"10.1.0.0/16"`             |
| public_cidrs   | List of CIDR blocks for public subnets                   | `list(string)` | `["10.1.1.0/24", "10.1.2.0/24"]` |
| private_cidrs  | List of CIDR blocks for private subnets                  | `list(string)` | `["10.1.3.0/24", "10.1.4.0/24"]` |
| create_rtb     | Whether to create the public route table                 | `bool`         | `true`                      |
| ingress_ports  | List of TCP ports to open for private security group     | `list(number)` | `[8080, 22]`                |

## Outputs

| Name                  | Description                            |
|-----------------------|----------------------------------------|
| public_subnets        | IDs of public subnets                  |
| private_subnet_ids    | IDs of private subnets                 |
| private_subnets       | IDs of private subnets (for expression)|
| aws_availability_zones| AWS availability zones used            |
| public_security_group | ID of public security group            |
| private_security_group| ID of private security group           |
| vpc_id                | ID of the created VPC                  |
| public_subnet1        | ID of the first public subnet          |
| private_subnet1       | ID of the first private subnet         |

## Backend Configuration

This module uses an S3 backend (see `main.tf`):

```hcl
terraform {
  backend "s3" {
    bucket  = "valaxy-terraform-state"
    key     = "dev/networking/terraform.tfstate"
    region  = "us-east-1"
    profile = "development"
  }
}
```

Update the backend configuration as needed for your environment.

## Requirements

- Terraform >= 1.0
- AWS provider >= 5.82.2

## Example

```hcl
provider "aws" {
  region  = "us-east-1"
  profile = "development"
}

module "vpc" {
  source        = "./aws-vpc-code"
  vpc_cidr      = "10.1.0.0/16"
  public_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
  private_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
  ingress_ports = [22, 8080]
}
```

## Notes

- The module creates 2 public and 2 private subnets by default, mapped to the first two availability zones in the region.
- Security groups and rules are customizable via input variables.
- NAT Gateway is deployed for private subnet internet access.

## License

MIT
