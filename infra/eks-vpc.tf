provider "aws" {
  region = "${var.eks-region}"
}

module "eks-vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs             = "${var.eks-azs}"
  private_subnets = "${var.eks-private-cidrs}"
  public_subnets  = "${var.eks-public-cidrs}"

  enable_nat_gateway = false
  single_nat_gateway = true

  enable_vpn_gateway = false

  enable_dns_hostnames = true

  tags = {
    Terraform                                   = "true"
    Environment                                 = "${var.environment_name}"
    "kubernetes.io/cluster/${var.cluster-name}" = "shared"
  }
}
