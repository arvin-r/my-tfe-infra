variable "vpc_cidr" {
    type = string
}

variable "instance_type" {
    default = "t2.micro"
    type = string
}

variable "app-subnets" {
    type = list
}

variable "app-subnet-names" {
    type = list  
}

variable "web-subnets" {
    type = list
}

variable "web-subnet-names" {
    type = list
}

variable "db-subnets" {
    type = list
}

variable "db-subnet-names" {
    type = list
}