#policy creation
resource "aws_iam_policy" "s3_ploicy" {
  name = "S3 policy"
  path = "/"
  description = "S3 buctket policy"


  policy = jsoncode({
    Version = "2012-10-12"
    Statement = [
      {
        Effect = "Allow" 
        Principal = "*"
        Action = "*"
        Resource = [
          aws_s3_bucket.example_bucket.arn,

          #the below aws bucket link allows access to everything to the bucket after /
          "${aws_s3_bucket.example_bucket.arn}/*",
        ]
      }
    ]
  })

}

#policy attachment to the user Anup_devops
resource "aws_iam_policy_attachment" "s3_full_access_policy_attachment" {
  name
}