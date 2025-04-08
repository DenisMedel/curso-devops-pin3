vpc_cidr_monitoreo = "10.0.0.0/16/24"

sub_public_monitoreo = "10.0.0.0/16/25"

sg_ingress_monitoreo = ["mi-ip-publica/32"]

ec2_ami_monitoreo = "ami-04d88e4b4e0a5db46"

ec2_instance_monitoreo = "t3.small"

tags = {
  "Owner" = "Curso-DevOps-Grupo-24"
  "Cliente" = "Curso DevOps"
  "Entorno" = "Monitoreo-Central"
  "IAC" = "Terraform"
  "IAC_Version" = "v1.10.5"
}
