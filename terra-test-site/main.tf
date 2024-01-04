# main configuration file where we will reference the vpc module

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
  souce = "../module/certificate_manager"
  domain_name = var.domain_name
  alternative_name - var.alternative_name
}