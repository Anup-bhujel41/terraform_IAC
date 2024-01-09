# creating aws vpn endpoint for  database
resource "aws_ec2_client_vpn_endpoint" "demo_vpn" {
  description = "AWS vpn endpoint"

  #new certificate need to be created using openssl for verification , comes in pair  so can be used for verification
  server_certificate_arn = 

  #pool of ip address that can access the vpn  
  client_cidr_block = ["10.0.1.0/24"]

  authentication_options {
    type = "certificate-authentication"
    root_certificate_chain_arn = 

  }

  connection_log_options{
    enabled = true
  }

}


#creating network association to the vpn and subnet
resource "aws_ec2_client_vpn_network_association" "demo_vpn_network_association" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.demo_vpn.id
  subnet_id = var.private_data_subnet_az1_id
}

#creating authorization rule
resource "aws_ec2_client_vpn_authorization_rule" "demo_vpn_authorization_rule" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.demo_vpn.id
  target_network_cidr = 
  authorize_all_groups = true
}

