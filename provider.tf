terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.2.0"
    }

  }
  backend "remote" {}
}

provider "aws" {

  region = var.region

}
