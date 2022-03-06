resource "aws_iam_role" "eks_cluster" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}


## EKS Cluster setup ###########

resource "aws_eks_cluster" "eks" {

  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn

  ## k8s Version
  version = var.k8s_version

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids = [
      module.vpc.private_subnets[0],
      module.vpc.private_subnets[1],
      module.vpc.private_subnets[2],
    ]
  }
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}
