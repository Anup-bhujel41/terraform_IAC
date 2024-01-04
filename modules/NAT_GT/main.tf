#creating NAT Gateway for the private subnets spread in two availability zones


#allocation of elastic ip fo the NAT Gateway for each availability zone (AZ1 and AZ2)
resource "aws_eip" "eip_for_nat_gateway_az1" {
  vpc = 

  tags = {
    Name = 
  }
}

#for AZ2
resource "aws_eip" "eip_for_nat_gateway_az2" {
  vpc = 

  tags = {
    Name = 
  }
}

#creating NAT Gateway for AZ1
resource "aws_nat_gateway" "nat_gateway_az1" {
  allocation_id = 
  subnet_id = 

  tags = {
    Name =
  }

  #to ensure proper ordering its is recommended to add an explicit dependency
  depends_on =

}

#creating NAT Gateway for AZ2
resource "aws_nat_gateway" "nat_gateway_az2" {
  allocation_id = 
  subnet_id = 

  tags = {
    Name =
  }

#to ensure proper ordering its is recommended to add an explicit dependency
#on the internet gateway for vpc
  depends_on = 
}


#create private rouute table az1 and add route through nat gateway az1
resource "aws_route_table" "private_route_table_az1" {
  vpc_id = 

  route {
    cidr_block = 
    nat_gateway_id = 
  }

  tags = {
    Name =
  }
}


#associate private app subnet az1 with private route table az1
resource "aws_route_table_association" "private_app_subnet_az1_route_table_association" {
  subnet_id = 
  route_table_id = 
}

#associate private data subnet az1 with private route table az1
resource "aws_route_table_association" "private_data_subnet_az1_route_table_association" {
  subnet_id = 
  route_table_id =

}

#create private route table az2 and add route through nat gateway az2
resource "aws_route_table" "private_route_table_az2" {
  vpc_id = 

  route {
    cidr_block = 
    nat_gateway_id = 
  }

  tags = {
    Name =
  }
}

#associate private app subnet az2 with private route table az2
resource "aws_route_table_association" "private_app_subnet_az2_route_table_association" {
  subnet_id = 
  route_table_id = 
}

#associate private data subnet az2 with private route table az2
resource "aws_route_table_association" "private_data_subnet_az2_route_table_association" {
  subnet_id = 
  route_table_id = 
}