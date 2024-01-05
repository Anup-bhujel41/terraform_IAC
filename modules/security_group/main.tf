# creating security group for the Application Load balancer
resource "aws_security_group" "alb_security_group" {
  name                    = "alb security group"
  description             = "enable http/https on port 80/443"
  vpc_id                  = var.vpc_id
  
#Inbound rules
  ingress {
    description           =  "http access"
    from_port             = 80
    to_port               = 80
    protocol              = "tcp"
    security_groups       = [aws_security_group.vpc_security_group.id]
  }

  ingress {
    description = "https access"
    from_port             = 443 
    to_port               = 443
    protocol              = "tcp"
    security_groups       = [aws_security_group.vpc_security_group.id]

  }

#Outbound rules
  egress {
    from_port             = 0
    to_port               = 0
    protocol              = -1
    cidr_blocks           = ["0.0.0.0/0"] 

  }

  tags                    = {
    Name                  = "alb security group"
  }

}

#create security group for the vpc
resource "aws_security_group" "vpc_security_group" {
  name                    = "ecs security group"
  description             = "enable http/https acces on port 80/443 via alb_sg"
  vpc_id                  = var.vpc_id

  #Inbound rules 
  ingress {
    description           = "http access"
    from_port             = 80
    to_port               = 80
    protocol              = "tcp"
    cidr_blocks           = ["0.0.0.0/0"]
    

  }

  ingress {
    description           = "https access"
    from_port             = 443
    to_port               = 443
    protocol              = "tcp"
    cidr_blocks           = ["0.0.0.0/0"]

  }

  # Outbound rules
  egress {
    from_port             = 0  
    to_port               = 0
    protocol              = -1
    cidr_blocks           = ["0.0.0.0/0"]

  }
  tags                    = {
    Name                  = "ecs security group"
  }
}

#creating security group for the ec2 instance in public subnet
resource "aws_security_group" "public_subnet_instance_sg" {
  name                    = "public_subnet_instance_sg"
  description             = "Public subnet instance inside vpc security group"
  vpc_id                  = var.vpc_id

  #Inbound Rules for the EC2 instance in public subnet
  ingress {
    description           = "http access for the EC2 instance in public subnet"
    from_port             = 80
    to_port               = 80
    protocol              = "tcp"
    security_groups       = [aws_security_group.alb_security_group.id]

  }

  ingress {
    description           = "https access for the EC2 instance in public subnet"
    from_port             = 443
    to_port               = 443
    protocol              = "tcp"
    security_groups       = [aws_security_group.alb_security_group.id]
  }

  #Outbound Rules
  egress {
    from_port             = 0
    to_port               = 0
    protocol              = -1
    cidr_blocks           = ["0.0.0.0/0"]
  }

  tags                    = {
    Name                  = "Sg for instance in public public_subnet_instance_sg"
  }
}

#security group for the rds instance placed in private subnet
resource "aws_security_group" "rds_security_group" {
  description             = "security group for the rds instance in private subnet in the vpc"
  name                    = "rds security group"
  vpc_id                  = var.vpc_id

  #inbound rules for the rds instance 
  ingress {
    description           = "https access for the rds instance"
    from_port             = 443
    to_port               = 443
    protocol              = "https"

    #place security group of the open vpn here not all cidr blocks
    cidr_blocks           = ["0.0.0.0/0"]
  }

  egress {
    from_port             = 0 
    to_port               = 0
    protocol              = -1
    cidr_blocks           = ["0.0.0.0/0"]
  }

  tags                    = {
    Name                  = "RDS security group"
  }



}