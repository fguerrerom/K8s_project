variable "region_blockstellart" {
  description = "La región de AWS donde se desplegarán los recursos"
  default     = "us-east-1"
}
variable "ami_id" {
  description = "value"
  default     = "ami-04b70fa74e45c3917"
}

variable "key_name" {
  description = "value"
  default     = "terraform"
}

variable "instance_type" {
  description = "value"
  default     = "t2.micro"
}
