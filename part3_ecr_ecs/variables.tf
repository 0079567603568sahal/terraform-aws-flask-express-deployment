variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "aws_account_id" {
  type = string
  description = "AWS Account ID"
}

variable "flask_ecr_name" {
  type    = string
  default = "flask-backend-repo"
}

variable "express_ecr_name" {
  type    = string
  default = "express-frontend-repo"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ecs_cluster_name" {
  type    = string
  default = "flask-express-cluster"
}

variable "flask_container_port" {
  type    = number
  default = 5000
}

variable "express_container_port" {
  type    = number
  default = 3000
}
