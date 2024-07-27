resource "aws_vpc" "DEV-VPC" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = var.common_tags
}

resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.DEV-VPC.id
  cidr_block = var.private-subnet-cidr

  tags = var.common_tags
}

resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.DEV-VPC.id
  cidr_block = var.public-subnet-cidr

  tags = var.common_tags
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.DEV-VPC.id

  route {
    cidr_block = var.public-rt-cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = var.common_tags
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.DEV-VPC.id

  route {
    cidr_block = var.private-rt-cidr
    gateway_id = aws_nat_gateway.nat-GW.id
  }

  tags = var.common_tags
}

resource "aws_route_table_association" "pub-rt-ass" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "priv-rt-ass" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.DEV-VPC.id

  tags = var.common_tags
}


resource "aws_nat_gateway" "nat-GW" {
     allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public-subnet.id

}



resource "aws_eip" "nat" {
   vpc = true
}



resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.DEV-VPC.id

  # INBOUND RULE
  ingress {
    description = "allow http inbound traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.inbound-rule-http
  }

  ingress {
    description = "allow https inbound traffic"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.inbound-rule-https
  }

  ingress {
    description = "allow ssh inbound traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.inbound-rule-ssh
  }

  # OUTBOUND RULE
  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.outbound-rule-all-traffic
  }

  tags = var.common_tags
}

