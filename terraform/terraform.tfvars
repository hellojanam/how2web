region_azs            = ["a","b","c"]
project_name          = "how2web"
num_public_subnets    = 3
num_private_subnets   = 3
cluster_name          = "how2web-eks"
cluster_version       = "1.30"
vpc_cidr              = "172.40.0.0/16"
helmfile_version      = "v0.143.0"
kubectl_version       = "v1.30.0"
public_key            = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCI6GZEYkOXlARDEtn7kNOCQrsyIUWGOPf03+4gb1WcjQENXXM1Dijo0XBXjdy712sFxREdL4/BcPD9u7fSDOAaPJRp/RxxsmdxPduWx+1rMVj91UUULeq+hOGQgFraUiPDhYxxiiWwmJ/M4jMLE919rQc5V1aQDTVzr0TjLJU6DR9gJwBa57+8RaaFN2HbnciUu763v12An5qCBOlxAXqrar3f95+3UWJdNhh7duG+ejrh2oa+cBCkdqqX99jYCTAm+iBMZUKgcn7HYtKK8obmGh7fcToC+E/WSbl36caN14/cFgccRA4BxisJo3askGibcbnlIS59T+hAo+nrboqB"
bastion_instance_type = "t3.micro"
nodegroup_ami_type    = "BOTTLEROCKET_x86_64"
common_tags           = {
    "Project-Name"  = "how2web"
    "Managed-By"    = "Terraform"
    "Environment"   = "Production"
    "Owner"         = "Cloudhero"    
}