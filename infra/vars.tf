variable "eks-region" {
  default = "us-east-1"
}

variable "eks-azs" {
  default = ["us-east-1a", "us-east-1b"]
}

variable "cluster-name" {
  default = "sp-cluster"
}

variable "environment_name" {
  default = "dev"
}

variable "eks-private-cidrs" {
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "eks-public-cidrs" {
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}