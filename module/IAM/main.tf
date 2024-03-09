# create an iam user
resource "aws_iam_user" "iam_user" {
  name = var.username
}



# create a group
resource "aws_iam_group" "G1" {
  name = var.group1
}



# adding a user to a group

resource "aws_iam_user_group_membership" "SingleGroup" {
  user = aws_iam_user.iam_user.name

  groups = [
    aws_iam_group.G1.name,
  ]
}


# give the first user a programatic access
resource "aws_iam_access_key" "user1" {
  user = aws_iam_user.iam_user.name
}

# give the first user a console access
resource "aws_iam_user_login_profile" "credentials" {
  user    = aws_iam_user.iam_user.name
  password_reset_required = true
}

# setting a policy so the user can change password when logging in the first time and also S3 full access
# The second policy statement allows the user to perform any action on the bucket you create in this configuration, but not on other buckets in the account
resource "aws_iam_user_policy" "user1" {
  name = var.policy_name
  user = aws_iam_user.iam_user.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
          "iam:ChangePassword",
          "ec2:*" //this is the administrative access for this user
        ]
        Effect = "Allow"
        Resource = "*"
      },
    ]
  })
  
}