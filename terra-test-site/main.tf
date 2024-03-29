]# main configuration file where we will reference the vpc module

#configure aws provider
provider "aws" {
  region                          = var.region

  #profile configured for aws with terraform user
  profile                         = ""

}

#create vpc by referencing the vpc module we created earlier
#all the variables defined in the module needs to be called in the module section here
module "vpc" {
  source                          = "../modules/vpc"
  region                          = var.region
  project_name                    = var.project_name
  vpc_cidr                        = var.vpc_cidr
  public_subnet_az1_cidr          = var.public_subnet_az1_cidr
  public_subnet_az2_cidr          = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr     = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr     = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr    = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr    = var.private_data_subnet_az2_cidr


}

#creating security group using the module
module "security_group" {
  source                          = "../modules/security_group"
  vpc_id                          = var.vpc_id
  client_cidr_block               = module.aws_vpn.client_cidr_block
}

#creating Application load balancer
module "application_load_balancer" {
  source                          = "../modules/alb"
  project_name                    = module.vpc.project_name
  alb_security_group_id           = module.security_group.alb_security_group_id
  public_subnet_az1_id            = module.vpc.public_subnet_az1_id
  public_subnet_az2_id            = module.vpc.public_subnet_az1_id
  vpc_id                          = module.vpc.vpc_id
  certificate_arn                 = module.acm.certificate_arn 

}

#Aws certificate manager for domain
module "acm" {
  source                           = "../module/certificate_manager"
  domain_name                     = var.domain_name
  alternative_name                = var.alternative_name
}


#creating Nat Gateway for private subnets in az1 and az2
module "nat_gateway" {
  source                          = "../modules/NAT_GT"
  vpc_id                          = module.vpc.vpc_id
  private_data_subnet_az2_id      = module.vpc.private_data_subnet_az2_id
  private_app_subnet_az2_id       = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az1_id      = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az1_id       = module.vpc.private_app_subnet_az1_id
  public_subnet_az1_id            = module.vpc.public_subnet_az1_id
  public_subnet_az2_id            = module.vpc.public_subnet_az2_id
  test_vpc_internet_gateway       = module.vpc.test_vpc_internet_gateway

}

#creating ec2 instance in public subnet using module
module "public_ec2_az1" {
  source = "../module/ec2_for_vpc"
  public_subnet_az1_id = module.vpc.public_subnet_az1_id
  alb_security_group_id = module.security_group.alb_security_group_id
  vpc_security_group_id = module.security_group.vpc_security_group_id
  public_subnet_instance_sg_id = module.security_group.public_subnet_instance_sg_id

}

#creating rds instance in the private subnet using module
module "rds" {
  source = "../module/rds"
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  rds_security_group_id = module.security_group.rds_security_group_id
  client_cidr_block = module.aws_vpn.client_cidr_block
}


#creating secrets manager for the credentials management
module "secrets_manager" {
  source = "../module/secrets_manager"
}

#creating module for aws aws_vpn
module "aws_vpn" {
  source = "../module/aws_vpn"
  private_data_subnet_az1_id = module.private_data_subnet_az1_id
}


#creating redis cluster
module "redis" {
  source = "../module/redis"
  
}

#creating s3 for static hosting
module "s3" {
  source = "../module/s3"
}