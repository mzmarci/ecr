variable "immutable_ecr_repositories" {
  default = "prod"
}

variable "erc_name" {
  default = "ecr_repo"
}

variable "scan_on_push" {
  type = bool
  description = "(Required) Indicates whether images are scanned after being pushed to the repository (true) or not scanned (false)."
  default = true
}