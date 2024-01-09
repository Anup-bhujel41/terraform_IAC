# resource for hosting s3 for static hosting
resource "aws_s3_bucket" "static_hosting" {
  bucket = "static-hosting"
  
  tags = {
    Name = "static_hosting"
  
  }
}


#creating access control for the s3 bucket
resource "aws_s3_bucket_acl" "static_hosting_acl" {
  bucket = aws_s3_bucket.static_hosting.id
  acl = "public-read"

}

#creating bucket policy
resource "aws_s3_bucket_policy"  "static_hosting_policy" {
  bucket = aws_s3_bucket.static_hosting.id

  policy = jsonencode({
    "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": "*",
                "Action": "s3:GetObject",
                "Resource": "arn:aws:s3:::static-hosting/*"
            }
        ]
  })
}

#static website hosting on the s3 bucket
resource "aws_s3_bucket_website_configuration" "static_hosting_website_configuration" {
  bucket = aws_s3_bucket.static_hosting.id

  index_document {
    suffix = "index.html"
  }
}

#uploading the files on the s3 bucket
resource "aws_s3_object" "static_hosting_files" {
  bucket = aws_s3_bucket.static_hosting.id

  for_each = fileset("${path.module}/../../static_website", "**/*")

  key          = each.key
  content_type = mime(each.key)  # Assuming you have mime type detection (e.g., using the mime function)

  source  = "${path.module}/../../static_website/${each.key}"
  content = file("${path.module}/../../static_website/${each.key}")

  etag = filemd5("${path.module}/../../static_website/${each.key}")
}
