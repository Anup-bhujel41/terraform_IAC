#creating iam user
resource "aws_iam_user" "terra_test_user" {
  name = "Anup_devops"
  system = "/system/"

  tags = {
    Name = "terra_test_user"
  }
}