resource "aws_vpc" "vpc_monitoreo" {
  cidr_block           = var.vpc_cidr_monitoreo
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name" = "vpc_monitoreo"
  }

}

resource "aws_internet_gateway" "igw_monitoreo" {
  vpc_id = aws_vpc.vpc_monitoreo.id

  tags = {
    "Name" = "igw_monitoreo"
  }

}

resource "aws_route_table" "rt_vpc_monitoreo" {
  vpc_id = aws_vpc.vpc_monitoreo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_monitoreo.id
  }

  tags = {
    "Name" = "rt_vpc_monitoreo"
  }

}

resource "aws_subnet" "sub_public_monitoreo_1" {
  vpc_id = aws_vpc.vpc_monitoreo.id
  cidr_block = var.sub_public_monitoreo_1
  availability_zone = var.sub_az_1
  map_public_ip_on_launch = true

  tags = {
    "Name" = "sub_public_monitoreo"
  }

}

resource "aws_subnet" "sub_public_monitoreo_2" {
  vpc_id = aws_vpc.vpc_monitoreo.id
  cidr_block = var.sub_public_monitoreo_2
  availability_zone = var.sub_az_2
  map_public_ip_on_launch = true

  tags = {
    "Name" = "sub_public_monitoreo_2"
  }
}

resource "aws_route_table_association" "rt_vpc_monitoreo_association_1" {
  subnet_id      = aws_subnet.sub_public_monitoreo_1.id
  route_table_id = aws_route_table.rt_vpc_monitoreo.id
}

resource "aws_route_table_association" "rt_vpc_monitoreo_association_2" {
  subnet_id      = aws_subnet.sub_public_monitoreo_2.id
  route_table_id = aws_route_table.rt_vpc_monitoreo.id
}

resource "aws_security_group" "sg_monitoreo" {
  name        = "sg_monitoreo"
  description = "Permite protocolo ssh y http"
  vpc_id      = aws_vpc.vpc_monitoreo.id

  ingress {
    description = "Permite Grafana"
    from_port   = 31000
    to_port     = 31000
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_monitoreo
  }

  ingress {
    description = "Permite SSH"
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

  tags = {
    Name = "sg_eks_monitoreo"
  }
}

resource "aws_security_group" "sg_control_plane" {
  name        = "sg_control_plane"
  description = "Permite acceso a la API de Kubernetes (EKS)"
  vpc_id      = aws_vpc.vpc_monitoreo.id

  ingress {
    description     = "Permite trafico de nodos EKS al API server"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.sg_monitoreo.id]
  }

  ingress {
    description = "Acceso desde mi VM a API Server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.sg_ingress_control_plane
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_control_plane"
  }
}
