variable "ami" {
    default = "ami-052c08d70def0ac62"
}

variable "instance-type"{
    default = "t2.micro"
}

variable "vpc-cidr" {
    default = "10.1.0.0/16"
}

variable "subnet-cidr" {
    default = "10.0.0.0/24"
}

variable "availability_zone" {
    default = "ap-south-1a"
}

variable "key_name" {
    default = "AWS_access"
}