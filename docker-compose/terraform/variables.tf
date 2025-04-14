variable "tags" {
  type        = map(string)
  description = "Tags del Proyecto"
}

variable "vpc_cidr_monitoreo" {
  type        = string
  description = "CIDR de la vcp Monitoreo APD"
}

variable "sub_public_monitoreo" {
  type        = string
  description = "CIDR de la Subnet Publica"
}

variable "sg_ingress_monitoreo" {
  type        = list(string)
  description = "CIDR para sg trafico ingress" 
}

variable "sg_ingress_traefik" {
  type        = list(string)
  description = "CIDR para sg trafico ingress"
}

variable "ec2_ami_monitoreo" {
  type        = string
  description = "ami de la instancia ec2 de monitoreo APD"
}

variable "ec2_instance_monitoreo" {
  type        = string
  description = "Tipo de instancia para ec2 para monitoreo APD"
}
