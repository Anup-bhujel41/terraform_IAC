#outputs for the vpn 
output "client_vpn_endpoint_id" {
  value = aws_ec2_client_vpn_endpoint.demo_vpn.id
}

output "client_cidr_block" {
  value = aws_ec2_client_vpn_endpoint.demo_vpn.client_cidr_block
} 