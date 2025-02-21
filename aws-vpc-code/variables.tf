variable "tag_name" {
  default     = "1.0.0"
  description = "The tag name to be associated to aws resources we create"
}

variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "public_cidrs" {
  default = ["10.1.1.0/24", "10.1.2.0/24"]
}

variable "private_cidrs" {
  default = ["10.1.3.0/24", "10.1.4.0/24"]
}

variable "create_rtb" {
  description = "Whether to create the public route table or not"
  type        = bool
  default     = true
}

variable "ingress_ports" {
  type        = list(number)
  description = "list of ingress ports"
  default     = [8080, 22]
}
