variable "cluster_name" {}
variable "private_subnets" {}
variable "vpc_id" {}
variable "project_name" {}

variable "general_nodes_instance_types" {
  default = ["t3.large"]
}

variable "node_group_name" {
  default = "general-nodes"
}

variable "eks_labels" {
  default = {
    role       = "worker-nodes"
    node-group = "general-nodes"
  }
}

variable "scaling_config" {
  default = {
    desired_size = 3
    max_size     = 10
    min_size     = 3
  }
}

variable "taints" {
  default = []
}
variable "nodegroup_ami_type" {
  description = "The AMI type to use for the EKS node group, e.g., BOTTLEROCKET_x86_64 or BOTTLEROCKET_ARM_64"
  type        = string
}