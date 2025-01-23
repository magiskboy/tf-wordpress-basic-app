provider "aws" {
  region = "ap-southeast-1"

  access_key = var.aws_client_id
  secret_key = var.aws_client_secret
}
