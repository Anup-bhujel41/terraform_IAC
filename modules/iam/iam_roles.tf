#creating assume role fopr ec2 instances to have access to s3 bucket
data "aws_iam_policy_document" "assume_role" {
  source_json = <<JSON
  {
    "Version": "2012-10-17"
    "Statement": [
      {
        "E"
      }
    ]
  }
}