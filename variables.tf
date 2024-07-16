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

#Public subnet
variable "pub-subnet01" {
    type = string
    description = "Public Subnet"
    default = "public-subnet01-ceb04"
}

#Private subnet
variable "priv-subnet01" {
    type = string
    description = "Private Subnet"
    default = "private-subnet01-ceb04"
}

#Internet Gateway
variable "igw-ceb04"{
    type = string
    description = "Internet Gateway"
    default = "ceb-daiana-internet-gateway"
}

#NAT Gateway
variable "nat-gw-ceb04"{
    type = string
    description = "NAT Internet Gateway"
    default = "ceb-daiana-nat-gateway"
}

#Public Route Table Name
variable "pub-rt-ceb04"{
    type = string
    description = "Public Route Tables"
    default = "ceb-daiana-public-rt"

}

#Private Route Table Name
variable "priv-rt-ceb04"{
    type = string
    description = "Private Route Table"
    default = "ceb-daiana-private-rt"
}


 #Aws Security Group 

 variable "security_group" {
    type = string
    description = "AWS Security Group Name"
    default = "allow-web"
}

#Aws instance
variable "aws_instance" {
    type = string
    description = "Type of AWS insatance"
    default = "t3.nano"
}

#SSH Key
variable "ssh_key" { 
    type = string
    description = "SSH key"
    default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnrrTQVU9sssfPrQXvL34avLxoEufQckgGLdQYoQIKN ww930\\a833267@DESKTOP-50NANP2"
}