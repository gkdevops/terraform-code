// Old Splat Syntax
output "public_subnets" {
  value = "${aws_subnet.public_subnet.*.id}"
}

// New Splat Syntax
output "private_subnet_ids" {
  value = [ aws_subnet.public_subnet[*].id ]
}

// For Expression in Terraform
output "private_subnets" {
  value = [
    for instance in aws_subnet.public_subnet:
    instance.id
  ]
}

// To print the data collected from data sources
output "aws_availability_zones" {
  value = data.aws_availability_zones.available
}

output "public_security_group" {
  value = "${aws_security_group.test_sg.id}"
}

output "private_security_group" {
  value = "${aws_security_group.sg_private.id}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

// To print Individual subnets from a List created
output "public_subnet1" {
  value = "${element(aws_subnet.public_subnet.*.id, 1)}"
}

output "private_subnet1" {
  value = "${element(aws_subnet.private_subnet.*.id, 1)}"
}
