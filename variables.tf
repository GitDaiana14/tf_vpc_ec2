#AWS region
variable "region" {
type = string
description = "Region"
default = "us-west-2"
}

#VPC Name
variable "vpc-ceb04" {
type = string
description = "VPC Name"
default = "vpc-ceb04"
}

#Created By
variable "ceb04" {
type = string
description = "Your Full Name"
default = "daiana cocar"
}

#VPC Ciddr
variable "vpc_ciddr" {
type = string
description = "VPC CIDDR block"
default = "ceb-Daiana"
}

variable "ssh_key" { 
    type = string
    description = "SSH key"
    default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnrrTQVU9sssfPrQXvL34avLxoEufQckgGLdQYoQIKN ww930\\a833267@DESKTOP-50NANP2"
}