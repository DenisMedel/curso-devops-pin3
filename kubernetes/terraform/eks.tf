module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.31"

  cluster_name    = "monitoreo-curso-g-24"
  cluster_version = "1.29"

  subnet_ids = [
    aws_subnet.sub_public_monitoreo_1.id,
    aws_subnet.sub_public_monitoreo_2.id
  ]

  vpc_id = aws_vpc.vpc_monitoreo.id

  eks_managed_node_groups = {
    default = {
      instance_types = [var.node_instance_type]
      min_size       = var.min_capacity
      max_size       = var.max_capacity
      desired_size   = var.desired_capacity
      
      ami_type = "AL2_x86_64"
      disk_size = 20
      
      iam_role_additional_policies = {
        AmazonEC2ContainerRegistryReadOnly = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
        AmazonEKSWorkerNodePolicy = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
        AmazonEKS_CNI_Policy = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
      }
    }
  }

  cluster_security_group_id = aws_security_group.sg_control_plane.id
  node_security_group_id    = aws_security_group.sg_monitoreo.id

  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = var.sg_ingress_control_plane

  create_cluster_security_group = false
  create_node_security_group    = false

  enable_irsa = true
}
