# create an iam user for the second user
resource "aws_iam_user" "iam_user1" {
  name = var.username1
}

# create a group for the second user
resource "aws_iam_group" "G2" {
  name = var.group2
}

# adding a second user to the second group
resource "aws_iam_user_group_membership" "SingleGroup1" {
  user = aws_iam_user.iam_user1.name

  groups = [
    aws_iam_group.G2.name,
  ]
}

# policy which gives the user a full access to ec2, ecr, and ecs

resource "aws_iam_user_policy" "user1" {
  name = var.policy_name
  user = aws_iam_user.iam_user1.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:*",
          "ecr:*",
          "ecs:*"
        ]
        Effect = "Allow"
        Resource = "*"
      },
    ]
  })
  
}