module "vpc" {
  source = "./modules/vpc"
  vpccidr = var.vpccidr
}

module "sg" {
    source = "./modules/sg"
    vpc_id = module.vpc.vpcid
}



module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source = "./modules/eks"
  masterrole = module.iam.masterrole
  public_subnet_az1_id  = module.vpc.sn1id
  public_subnet_az2_id  = module.vpc.sn2id
  worker_arn = module.iam.workerrole
  instance_size         = var.instance_size
  eks_security_group_id = module.sg.sgid
  worker_node_count                 = var.instance_count
  

}

