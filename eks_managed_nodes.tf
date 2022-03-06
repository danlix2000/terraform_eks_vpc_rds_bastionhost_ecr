resource "aws_iam_role" "nodes_eks" {
  name               = "role-node-group-eks"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }, 
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes_eks.name
}

resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_eks" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes_eks.name
}

resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes_eks.name
}


resource "aws_eks_node_group" "nodes_eks" {

  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "nodes-first-pool"
  node_role_arn   = aws_iam_role.nodes_eks.arn
  subnet_ids      = module.vpc.private_subnets
  remote_access {
    ec2_ssh_key = aws_key_pair.ssh_key.id

  }

  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 2
  }

  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = 20
  force_update_version = false
  instance_types       = ["t2.small"]
  labels = {
    role = "nodes-pool-1"
  }

  version = var.k8s_version

  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_eks,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_eks,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}

