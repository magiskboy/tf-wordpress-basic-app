variable "aws_client_id" {
  type = string
}

variable "aws_client_secret" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type = string
}

variable "db_name" {
  type = string 
  default = "wordpress"
}
