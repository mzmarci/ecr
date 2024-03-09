module "IAM" {
  source      = "./module/IAM"
  username    = var.username
  group1      = var.group1
  policy_name = var.policy_name
}

module "IAM1" {
  source      = "./module/IAM1"
  username1   = var.username1
  group2      = var.group2
  policy_name = var.policy_name
}

module "ECR" {
  source = "./module/ecr"
  
}