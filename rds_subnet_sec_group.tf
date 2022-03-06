resource "aws_db_subnet_group" "pgsub" {
  name       = "postgresql-subnets"
  subnet_ids = [module.vpc.private_subnets[0], module.vpc.private_subnets[1]]

  tags = {
    Environment = "Pgsql-dev"
    Name        = "postgresql-dev"
  }
}

resource "aws_security_group" "pgsg" {
  name        = "postgresql-sec-grp"
  description = "Allow inbound/outbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = module.vpc.private_subnets_cidr_blocks

  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = module.vpc.public_subnets_cidr_blocks

  }

  tags = {
    Name        = "postgresql-dev"
    Environment = "pg-dev"
  }
}