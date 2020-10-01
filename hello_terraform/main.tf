provider "aws" {
  version    = "3.4.0"
  region     = "us-east-1"
  access_key = "AKIAJAPEC2Z3LMPOQ2PQ"
  secret_key = "1WenKS70e59j2Vu06wKVCE51mBulP5mIsE4ui5oO"
}

resource "aws_instance" "example" {
  ami = "ami-098f16afa9edf40be"
	instance_type = "t2.micro"
	key_name      = "aws"

	tags = {
	  Name = "Terraform Created"
	}
}
