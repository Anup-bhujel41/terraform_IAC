#creating NAT Gateway for the private subnets spread in two availability zones


#allocation of elastic ip fo the NAT Gateway for each availability zone (AZ1 and AZ2)
resource "aws_eip" "eip_for_nat_gateway_az1" {
  vpc                     = true

  tags                    = {
    Name                  = "Elastic ip for nat gateway az1"
  }
}

#for AZ2
resource "aws_eip" "eip_for_nat_gateway_az2" {
  vpc                     = true

  tags                    = {
    Name                  = "Elastic ip for nat gateway az2"
  }
}

#creating NAT Gateway for AZ1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id           = aws_eip.eip_for_nat_gateway_az1.id
  subnet_id               = var.public_subnet_az1_id

  tags                    = {
    Name                  ="Nat Gateway AZ1"
  }

  #to ensure proper ordering its is recommended to add an explicit dependency
  depends_on              = [var.test_vpc_internet_gateway]

}

#creating NAT Gateway for AZ2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id           = aws_eip.eip_for_nat_gateway_az2.id
  subnet_id               = var.public_subnet_az2_id

  tags                    = {
    Name                  = "Nat Gateway AZ2"
  }

#to ensure proper ordering its is recommended to add an explicit dependency
#on the internet gateway for vpc
  depends_on              = [var.test_vpc_internet_gateway]
}


#create private rouute table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id                  = var.vpc_id

  route {
    cidr_block            = ["0.0.0.0/0"]
    nat_gateway_id        = aws_nat_gateway.nat_gateway_az1.id
  }

  tags                    = {
    Name                  = "Private route table for AZ1 through nat gateway az1"
  }
}


#associate private app subnet az1 with private route table az1
resource "aws_route_table_association" "private_app_subnet_az1_route_table_association" {
  subnet_id               = var.private_app_subnet_az1_id
  route_table_id          = aws_route_table.private_route_table_az1.id
}

#associate private data subnet az1 with private route table az1
resource "aws_route_table_association" "private_data_subnet_az1_route_table_association" {
  subnet_id               = var.private_data_subnet_az1_id
  route_table_id          = aws_route_table.private_route_table_az1.id

}

#create private route table az2 and add route through nat gateway az2
resource "aws_route_table" "private_route_table_az2" {
  vpc_id                  = var.vpc_id

  route {
    cidr_block            = ["0.0.0.0/0"]
    nat_gateway_id        = aws_nat_gateway.nat_gateway_az2.id
  }

  tags                    = {
    Name                  = "Private route table for AZ2 through nat gateway az2"
  }
}

#associate private app subnet az2 with private route table az2
resource "aws_route_table_association" "private_app_subnet_az2_route_table_association" {
  subnet_id               = var.private_app_subnet_az2_id
  route_table_id          = aws_route_table.private_route_table_az2.id
}

#associate private data subnet az2 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az2_route_table_association" {
  subnet_id               = var.private_data_subnet_az2_id
  route_table_id          = aws_route_table.private_route_table_az2.id
}