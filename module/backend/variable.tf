variable "bucket" {
  default = "mercy-key-bucket"
}

variable "versioning-bucket" {
  default = "key-versioning-bucket"
}

variable "immutable_ecr_repositories" {
  default = "MUTABLE"
}