variable "policy_name" {
  type    = string
  default = "default_policy_name"
}

variable "username" {
  type    = string
  default = "user"
}

variable "username1" {
  type    = string
  default = "user1"
}

variable "group1" {
  type    = string
  default = "G1"
}

variable "group2" {
  type    = string
  default = "G2"
}

variable "bucket" {
  default = "mercy-key-bucket"
}

variable "versioning-bucket" {
  default = "key-versioning-bucket"
}

variable "immutable_ecr_repositories" {
  default = "MUTABLE"
}