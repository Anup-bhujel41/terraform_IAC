# copy all variables from the vpc module variable.tf
variable "region" {}
variable "project_name" {}
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}

#new variablesneeds to be aaded to the project file
variable "domain_name" {}
variable "alternative_name" {}

variable "public_subnet_instance_sg_id" {}
variable "alb_security_group_id" {}
variable "vpc_security_group_id" {}

variable "rds_security_group_id" {}
variable "client_cidr_block" {}
variable "redis_security_group_id" {}
