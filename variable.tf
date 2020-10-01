variable "ami" {
    default = "ami-052c08d70def0ac62"
}

variable "instance-type"{
    default = "t2.micro"
}

variable "vpc-cidr" {
    default = "10.0.0.0/16"
}

variable "subnet-cidr-public-1" {
    default = "10.0.0.0/24"
}

variable "subnet-cidr-public-2" {
    default = "10.0.1.0/24"
}

variable "availability_zone_1a" {
    default = "ap-south-1a"
}

variable "availability_zone_1b" {
    default = "ap-south-1b"

}
variable "key_name" {
    default = "AWS_access"
}