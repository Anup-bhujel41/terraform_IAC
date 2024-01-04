#variables for creating NAT gateway
variable "vpc_id" {}
variable "private_data_subnet_az2_id" {}
variable "private_app_subnet_az2_id" {}
variable "private_data_subnet_az1_id" {}
variable "private_app_subnet_az1_id" {}
variable "public_subnet_az1_id" {}
variable "public_subnet_az2_id" {}
variable "test_vpc_internet_gateway" {}