variable aws_access_key {
  default = ""
}

variable aws_secret_key {
  default = ""
}

variable "zone" {
  default = "eu-west-1"
}

variable "ami" {
  default = "ami-0ff760d16d9497662"
}

variable "cidr" {
  default     = "0.0.0.0/0"
}

variable "public_nets" {
  type        = "list"
  default     = []
}

variable "Create_by" {
  default = "YD"
}