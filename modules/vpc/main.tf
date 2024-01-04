#vpc creation
resource "aws_vpc" "test_vpc" {
  cidr_block                =  var.vpc_cidr
  instance_tenancy          = "default"
  enable_dns_hostname       = true

  tags                      = {
    Name                    = "${var.project_name}-vpc"
  }
}


#create internet gateway
resource "aws_internet_gateway" "test_vpc_internet_gateway" {
  vpc_id                    = aws_vpc.test_vpc.id 

  tags                      = { 
    Name                    = "${var.project_name}-igw"
  }
}


#use data source to get list of all availability zones in the region
data "aws_availability_zones" "available_zones" {}


#create public subnet in available zone 1
resource "aws_subnet" "public_subnet_az1" {
  vpc_id                    = aws_vpc.test_vpc.id
  cidr_block                = var.public_subnet_az1_cidr
  availability_zone         = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch   = true

 tags = {
  Name = "public subnet az1"
 }
}


#create public subnet in available zone 2
resource "aws_subnet" "public_subnet_az2" {
  vpc_id                    = aws_vpc.test_vpc.id
  cidr_block                = var.public_subnet_az2_cidr
  availability_zone         = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch   = true

 tags                       = {
  Name                      = "public subnet az2"
 }
}

#create route table for the public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id                    = aws_vpc.test_vpc.id

  route {

    #destination of the route table
    cidr_block              = "0.0.0.0/0"

    #Internet gateway id
    gateway_id              = aws_internet_gateway.test_vpc_internet_gateway.id

  }

  tags                      = {
    Name                    = "public route table"
  }
}

#associate route table to the public public_subnet_az1
resource "aws_route_table_association" "public_subnet_az1_route_table_association" {
  subnet_id                 = aws_subnet.public_subnet_az1.id
  route_table_id            = aws_route_table.public_route_table.id

}

#associate route table to the public public_subnet_az2
resource "aws_route_table_association" "public_subnet_az2_route_table_association" {
  subnet_id                 = aws_subnet.public_subnet_az2.id
  route_table_id            = aws_route_table.public_route_table.id

}

#create private app subnet in az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                    = aws_vpc.test_vpc.id
  cidr_block                = var.private_app_subnet_az1_cidr
  availability_zone         = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch   =  false

  tags                      = {
    Name                    = private app subnet az1
  }
}

#create private app subnet in az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                    = aws_vpc.test_vpc.id
  cidr_block                = var.private_app_subnet_az2_cidr
  availability_zone         = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch   = false

  tags                      = {
    Name                    = "private app subnet az2"
  }
}

#create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                    = aws_vpc.test_vpc.id
  cidr_block                = var.private_data_subnet_az1_cidr
  availability_zone         = data.aws_availability_zones.available_zones.names[0]
  map_public_ip_on_launch   = false

  tags                      = {
    Name                    = "private data subnet az1"
  }
}


#create private private_data_subnet_az2
resource "aws_subnet" " private_data_subnet_az2" {
  vpc_id                    = aws_vpc.test_vpc.id
  cidr_block                = var.private_data_subnet_az2_cidr
  availability_zone         = data.aws_availability_zones.available_zones.names[1]
  map_public_ip_on_launch   = false

  tags                      = {
    Name                    = "private data subnet az2"
  }
}

