resource "aws_security_group" "sp-cluster" {
  name        = "terraform-eks-sp-cluster"
  description = "Cluster communication with worker nodes"
  vpc_id      = "${module.eks-vpc.vpc_id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "terraform-eks-demo"
  }
}

resource "aws_security_group_rule" "sp-cluster-ingress-workstation-https" {
  cidr_blocks       = ["98.144.142.69/32"]
  description       = "Allow my mac to communicate with the cluster API Server"
  from_port         = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.sp-cluster.id}"
  to_port           = 443
  type              = "ingress"
}

resource "aws_security_group_rule" "sp-cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.sp-cluster.id}"
  source_security_group_id = "${aws_security_group.sp-node.id}"
  to_port                  = 443
  type                     = "ingress"
}