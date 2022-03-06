resource "aws_key_pair" "ssh_key" {
  key_name   = "eks_ssh_name"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx dnlixkey"
}

