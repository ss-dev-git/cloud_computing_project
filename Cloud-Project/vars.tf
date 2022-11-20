variable "aws_ec2_policy_arn" {
  type        = list(string)
  description = "Policies attached to EC2 instance role."
  default     = ["arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM", "arn:aws:iam::aws:policy/AmazonSSMManagedEC2InstanceDefaultPolicy" ,"arn:aws:iam::aws:policy/AmazonEC2FullAccess", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore", "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"]
}

variable "org_id" {
    type = string
    #required
}

variable "ami_id" {
    type = string
    default  = "ami-09d3b3274b6c5d4aa"
}

variable "instance_type" {
    type = string
    default  = "t2.micro"
}

variable "instance_key" {
    type = string
    #required
}


variable "cidr_block" {
    type = string
    default  = "0.0.0.0/0"
}

variable "route_53_domain" {
    type = string
    #required
}

variable "vpc_cidr" {
    type = string
    #required
}

variable "public_subnet_cidr1" {
    type = string
    #required
}

variable "public_subnet_cidr2" {
    type = string
    #required
}

variable "public_subnet_cidr3" {
    type = string
    #required
}

variable "subnet_az" {
    type = string
    #required
}

variable "subnet_az_1" {
    type = string
    #required
}

variable "subnet_az_2" {
    type = string
    #required
}


variable "html_files" {
    type = set(string)
}
variable "pics" {
    type = set(string)
}