resource "aws_vpc" "vpc_monitoreo" {
  cidr_block           = var.vpc_cidr_monitoreo
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Nombre" = "vcp_monitoreo"
  }

}

resource "aws_internet_gateway" "igw_monitoreo" {
  vpc_id = aws_vpc.vpc_monitoreo.id

  tags = {
    "Nombre" = "igw_monitoreo"
  }

}

resource "aws_subnet" "sub_public_monitoreo" {
  vpc_id = aws_vpc.vpc_monitoreo.id
  cidr_block = var.sub_public_monitoreo
  map_public_ip_on_launch = true

  tags = {
    "Nombre" = "sub_public_monitoreo"
  }

}

resource "aws_route_table" "rt_vpc_monitoreo" {
  vpc_id = aws_vpc.vpc_monitoreo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_monitoreo.id
  }

  tags = {
    Name = "rt_vpc_monitoreo"
  }

}

resource "aws_route_table_association" "rt_vpc_monitoreo_association" {
  subnet_id      = aws_subnet.sub_public_monitoreo.id
  route_table_id = aws_route_table.rt_vpc_monitoreo.id
}

resource "aws_security_group" "sg_monitoreo" {
  name        = "sg_monitoreo"
  description = "Permite protocolo ssh y http"
  vpc_id      = aws_vpc.vpc_monitoreo.id

  ingress {
    description = "Allow inbound HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_monitoreo
  }

  ingress {
    description = "Permite entrada HTTPs Traefik"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_traefik
  }

  ingress {
    description = "Allow inbound SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_monitoreo
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
