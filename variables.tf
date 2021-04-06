variable "az" {
  description = "Availability Zone"
  type = string
  default = "us-east-1a"
}

variable "instance_type" {
  description = "The type of instance to start"
  type = string
  default = "t2.micro"
}

variable "key_name" {
  description = "The key name to use for the instance"
  type  = string
  default = ""
}

