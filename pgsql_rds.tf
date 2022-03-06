resource "random_string" "db_snapshot" {
  length  = 4
  special = false
  upper   = false
}

resource "aws_db_instance" "postgresql" {

  engine                              = "postgres"
  engine_version                      = "13.4"
  db_name                             = "dandb"
  identifier                          = "danlixpostgre-dev"
  username                            = "pgadmin"
  password                            = var.pg_password
  instance_class                      = "db.t3.micro"
  storage_type                        = "gp2"
  allocated_storage                   = 20
  max_allocated_storage               = 100
  multi_az                            = false
  db_subnet_group_name                = aws_db_subnet_group.pgsub.id
  publicly_accessible                 = false
  vpc_security_group_ids              = [aws_security_group.pgsg.id]
  port                                = 5432
  iam_database_authentication_enabled = false
  parameter_group_name                = "default.postgres13"
  backup_retention_period             = 7
  backup_window                       = "22:00-23:00"
  final_snapshot_identifier           = "postgresql-snapshot-dev-${random_string.db_snapshot.result}"
  delete_automated_backups            = true
  skip_final_snapshot                 = false
  storage_encrypted                   = true
  auto_minor_version_upgrade          = true
  maintenance_window                  = "Sat:00:00-Sat:02:00"
  deletion_protection                 = false
  tags = {
    Environment = "pg-dev"
  }

}