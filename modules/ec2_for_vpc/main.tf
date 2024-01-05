# main configuration for the ec2 instance deployment in vpc

data "aws_ami" "ubuntu" {
  most_recent             = true

  filter {
    name                  = "name"
    values                = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name                  = "virtualization-type"
    values                = ["hvm"]
  }

  owners                  = ["099720109477"] # Canonical
}

resource "aws_instance" "Public_subnet_ec2_instance" {
  ami_id                  = data.aws_ami.ubuntu.id
  subnet_id               = var.public_subnet_az1_id
  instance_type           = "t3.micro"
  vpc_security_group_ids  = [var.alb_security_group_id,var.vpc_security_group_id,var.public_subnet_instance_sg_id]


  tags                    = {
  Name                    = "Public subnet ec2 instance"
  }

}