resource "aws_ecr_repository" "ecr_repository" {
  name      = var.erc_name
  image_tag_mutability = var.immutable_ecr_repositories == "prod" ? "MUTABLE" : "IMMUTABLE"
  force_delete = true
  image_scanning_configuration  {
    scan_on_push = var.scan_on_push
  }
  
  encryption_configuration {
    encryption_type = "KMS"
  }

  tags = {
    Name = "first ECR Repo"
    Group = "test"
  }
}

//To create ECR Repository with lifecycle policy that expires untagged images older than 14 days
resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  repository     = aws_ecr_repository.ecr_repository.name

  policy = <<EOF
{
    "rules": [
        {
                "rulePriority": 1,
                "description": "Expire images older than 14 days",
                "selection": {
                    "tagStatus": "untagged",
                    "countType": "sinceImagePushed",
                    "countUnit": "days",
                    "countNumber": 14
                },
                "action": {
                    "type": "expire"
                    
                }
            
        }
    ]   
}
EOF
}

//To create ECR Repository with lifecycle policy that expires tagged images older than 14 days
resource "aws_ecr_lifecycle_policy" "ecr_policy1" {
  repository     = aws_ecr_repository.ecr_repository.name

  policy = <<EOF
{
    "rules": [
        {
                "rulePriority": 1,
                "description": "Expire images older than 14 days",
                "selection": {
                    "tagStatus": "any",
                    "countType": "sinceImagePushed",
                    "countUnit": "days",
                    "countNumber": 14
                },
                "action": {
                    "type": "expire"
                    
                }
            
        }
    ]   
}
EOF
}