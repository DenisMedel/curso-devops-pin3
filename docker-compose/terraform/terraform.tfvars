vpc_cidr_monitoreo = "10.0.0.0/16"

sub_public_monitoreo = "10.0.0.0/24"

sg_ingress_monitoreo = ["mi-ip-publica"]

sg_ingress_traefik = ["0.0.0.0/0"]

ec2_ami_monitoreo = "ami-0fc5d935ebf8bc3bc"

ec2_instance_monitoreo = "t3.small"

tags = {
  "Owner" = "Curso-DevOps-Grupo-24"
  "Cliente" = "Curso DevOps"
  "Entorno" = "Monitoreo-Central"
  "IAC" = "Terraform"
  "IAC_Version" = "v1.10.5"
}
