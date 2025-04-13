variable "tags" {
  type        = map(string)
  description = "Tags del Proyecto"
}

### REDES ###
#############
variable "vpc_cidr_monitoreo" {
  type        = string
  description = "CIDR de la vcp Monitoreo"
}

variable "sub_public_monitoreo_1" {
  type        = string
  description = "CIDR de la Subnet Publica"
}

variable "sub_public_monitoreo_2" {
  type        = string
  description = "CIDR de la Subnet Publica 2"
}

variable "sub_az_1" {
  type        = string
  description = "Zona de Disponibilidad subnet 1"
}

variable "sub_az_2" {
  type        = string
  description = "Zona de Disponibilidad subnet 2"
}

variable "sg_ingress_monitoreo" {
  type        = list(string)
  description = "CIDR para sg nodos monitoreo" 
}

variable "sg_ingress_control_plane" {
  type        = list(string)
  description = "CIDR para sg cluster eks"
}

### EKS ###
###########
variable "node_instance_type" {
  type = string
  description = "Tipo de Instancia para Nodos Workers"
}

variable "desired_capacity" {
  type = string
  description = "Workers Deseados / Por Default"
}

variable "max_capacity" {
  type = string
  description = "Capacidad de Workers Máximos"
}

variable "min_capacity" {
  type = string
  description = "Capacidad de Workers Mínimos"
}
