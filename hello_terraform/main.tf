# This is my first terraform code

/* This
is a 
multi line comment */

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA4ESCETGQ7QCG3XHW"
  secret_key = "nDVXYNTO0EjABBE2WYOSmmwObyvvSo48a/xwg1xd"
}

resource "aws_instance" "example" {
  ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t2.micro"
  key_name      = "aws"

  tags = {
    Name = "Created by Terraform"
  }
}
