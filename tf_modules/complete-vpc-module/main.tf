# Query all available Availability Zones
data "aws_availability_zones" "available" {}

# VPC Creation
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

# Creating Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-igw"
    Environment = var.environment
  }
}

# Public Route Table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name        = "${var.environment}-public-route"
    Environment = var.environment
  }
}

# Private Route Table
resource "aws_default_route_table" "private_route" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
    cidr_block     = "0.0.0.0/0"
  }

  tags = {
    Name        = "${var.environment}-private-route"
    Environment = var.environment
  }
}

# Public Subnets
resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_cidrs)
  cidr_block              = var.public_cidrs[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.environment}-public-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_cidrs)
  cidr_block        = var.private_cidrs[count.index]
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "${var.environment}-private-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_subnet_assoc" {
  count          = length(var.public_cidrs)
  route_table_id = aws_route_table.public_route.id
  subnet_id      = aws_subnet.public_subnet[count.index].id
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_subnet_assoc" {
  count          = length(var.private_cidrs)
  route_table_id = aws_default_route_table.private_route.id
  subnet_id      = aws_subnet.private_subnet[count.index].id
}

# Public Security Group
resource "aws_security_group" "public_sg" {
  name   = "${var.environment}-public-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.environment}-public-sg"
    Environment = var.environment
  }
}

# Public Security Group Rules
resource "aws_security_group_rule" "ssh_inbound_access" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.public_sg.id
  to_port          = 22
  type             = "ingress"
  cidr_blocks      = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "http_inbound_access" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.public_sg.id
  to_port          = 80
  type             = "ingress"
  cidr_blocks      = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "all_outbound_access" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.public_sg.id
  to_port          = 0
  type             = "egress"
  cidr_blocks      = ["0.0.0.0/0"]
}

# Private Security Group
resource "aws_security_group" "private_sg" {
  name        = "${var.environment}-private-sg"
  description = "Private security group"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  tags = {
    Name        = "${var.environment}-private-sg"
    Environment = var.environment
  }
}

# NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name        = "${var.environment}-nat-eip"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name        = "${var.environment}-nat-gateway"
    Environment = var.environment
  }
}
