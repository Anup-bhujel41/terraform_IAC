#outputs generated are 
output "static_hosting_id" {
  value = aws_s3_bucket.static_hosting.id
}


output "website_url" {
  value = aws_s3_bucket_website_configuration.static_hosting_website_configuration.website_endpoint
}