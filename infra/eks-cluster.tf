provider "aws" {
  region = "${var.eks-region}"
}


resource "aws_eks_cluster" "demo" {
  name            = "${var.cluster-name}"
  role_arn        = "${aws_iam_role.demo-cluster.arn}"

  vpc_config {
    security_group_ids = ["${aws_security_group.demo-cluster.id}"]
    subnet_ids         = ["${aws_subnet.demo.*.id}"]
  }

  depends_on = [
    "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy",
    "aws_iam_role_policy_attachment.demo-cluster-AmazonEKSServicePolicy",
    "aws_vpc.demo",
    "aws_subnet.demo",
  ]
}

#####################################################################
#####################################################################
#                                                                   #
#             No longer need this output as you can use             #
#                              aws-cli                              #
#          aws eks update-kubeconfig --name <cluster_name>          #
#                                                                   #
#####################################################################
#####################################################################

# locals {
#   kubeconfig = <<KUBECONFIG
# apiVersion: v1
# clusters:
# - cluster:
#     server: ${aws_eks_cluster.demo.endpoint}
#     certificate-authority-data: ${aws_eks_cluster.demo.certificate_authority.0.data}
#   name: kubernetes
# contexts:
# - context:
#     cluster: kubernetes
#     user: aws
#   name: aws
# current-context: aws
# kind: Config
# preferences: {}
# users:
# - name: aws
#   user:
#     exec:
#       apiVersion: client.authentication.k8s.io/v1alpha1
#       command: aws-iam-authenticator
#       args:
#         - "token"
#         - "-i"
#         - "${var.cluster-name}"
# KUBECONFIG
# }

# output "kubeconfig" {
#   value = "${local.kubeconfig}"
# }
