output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}


output "ecr-repo" {
  value = aws_ecr_repository.ecr-danlix.id

}


output "rds-username" {
  value = aws_db_instance.postgresql.username
}

output "rds-password" {
  value     = aws_db_instance.postgresql.password
  sensitive = true
}

output "private-rds-endpoint" {
  value = aws_db_instance.postgresql.address
}

output "bastion_public_ip" {
  value = aws_eip.bas_ip
}