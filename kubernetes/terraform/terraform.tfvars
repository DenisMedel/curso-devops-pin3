### REDES ###
#############
vpc_cidr_monitoreo = "10.0.0.0/16"

sub_public_monitoreo_1 = "10.0.0.0/24"

sub_public_monitoreo_2 = "10.0.1.0/24"

sub_az_1 = "us-east-1a"

sub_az_2 = "us-east-1b"

sg_ingress_monitoreo = ["mi-ip-publica/32"]

sg_ingress_control_plane = ["mi-ip-publica/32"]

### EKS ###
###########
node_instance_type = "t3.medium"

desired_capacity = "1"

max_capacity = "3"

min_capacity = "1"

### TAGS ###
############
tags = {
  "Owner" = "Curso-DevOps-Grupo-24"
  "Cliente" = "Curso DevOps"
  "Entorno" = "Monitoreo"
  "IAC" = "Terraform"
  "IAC_Version" = "v1.10.5"
}
