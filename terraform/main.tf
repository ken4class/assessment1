
provider "aws" {}

variable "iam-user" {
    type = set(string)
  default = (["user1", "user2", "user3"])
}

# Retrieve the user ARN
data "aws_iam_users" "users" {}

# Define the IAM role
resource "aws_iam_role" "example_role" {
  name               = "example-role"
  assume_role_policy = jsonencode(
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": data.aws_iam_users.users.arns
      },
      "Action": "sts:AssumeRole"
    }
  ]
})
}


#Policy to allow above users assume the above role
resource "aws_iam_policy" "policy" {
  name        = "asume-policy"
  description = "policy to allow user assume the role"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        "Effect": "Allow",
    "Action": "sts:AssumeRole",
    "Resource": aws_iam_role.example_role.arn
      },
    ]
  })
}

#Create a IAM group
resource "aws_iam_group" "group" {
  name = "test-group"
}

#Attach policy to the group
resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.policy.arn
}

#Create an IAM users looping thru the variables
resource "aws_iam_user" "user1" {
   for_each = var.iam-user
  name = each.key
}

#Add users to this group
resource "aws_iam_user_group_membership" "grp_member" {
  for_each = aws_iam_user.user1
  user = each.key
  groups = [
    aws_iam_group.group.name,
  ]
}