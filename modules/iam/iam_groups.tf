#creating iam group
resource "aws_iam_group" "devops" {
  name = "Devops Group"
  path = "/terra_test_user/"

}

resource "aws_iam_group_membership" "devops_group_membership" {
  name = "devops_group_membership"
   users = [
    aws_iam_user.terra_test_user.name
   ]

   group = aws_iam_group.devops.name
   


}