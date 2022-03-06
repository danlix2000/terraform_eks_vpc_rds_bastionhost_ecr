variable "region" {
  default     = "us-west-2"
  description = "AWS region"
}

variable "pg_password" {
  description = "Database administrator password"
  type        = string

  default = "hdsiJu57324Lofsadad"
}

variable "rds_db_name" {
  type    = string
  default = "rates"
}
#############

variable "cluster_name" {
  type    = string
  default = "danlix-dev-eks"
}

variable "k8s_version" {
  type    = number
  default = "1.21"

}


