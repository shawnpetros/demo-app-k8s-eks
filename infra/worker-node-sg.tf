resource "aws_security_group" "sp-node" {
  name        = "terraform-eks-sp-node"
  description = "Security group for all nodes in the cluster"
  vpc_id      = "${module.eks-vpc.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${
    map(
     "Name", "terraform-eks-sp-node",
     "kubernetes.io/cluster/${var.cluster-name}", "owned",
    )
  }"
}

resource "aws_security_group_rule" "sp-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = "${aws_security_group.sp-node.id}"
  source_security_group_id = "${aws_security_group.sp-node.id}"
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "sp-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sp-node.id}"
  source_security_group_id = "${aws_security_group.sp-cluster.id}"
  to_port                  = 65535
  type                     = "ingress"
}