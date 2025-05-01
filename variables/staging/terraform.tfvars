environment = "staging"
instance_type = "t2.medium"
vpc_cidr = "172.16.0.0/16"
public_subnets_cidr = ["172.16.1.0/24", "172.16.2.0/24"]
private_subnets_cidr = ["172.16.10.0/24", "172.16.20.0/24"]
availability_zones = ["us-east-2a", "us-east-2b"] 