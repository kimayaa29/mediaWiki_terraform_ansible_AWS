variable "ami" {
    default = "ami-052c08d70def0ac62"
}

variable "instance-type"{
    default = "t2.micro"
}

variable "vpc-cidr" {
    default = "10.0.0.0/16"
}

variable "sub-a-cidr" {
    default = "10.0.0.0/24"
}

variable "sub-b-cidr" {
    default = "10.0.1.0/24"
}

variable "key_name" {
    default = "AWS_access"

}