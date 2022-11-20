module "web" {
 source = "../Cloud-Project"
org_id = "ksu"
instance_type = "t2.micro"
instance_key = "Enter instance key name"
route_53_domain = "Enter domain name"
vpc_cidr = "Enter CIDR BLOCK"
public_subnet_cidr1 = "Enter CIDR BLOCK"
public_subnet_cidr2 = "Enter CIDR BLOCK"
public_subnet_cidr3 = "Enter CIDR BLOCK"
subnet_az = "Enter Subnet AZ"
subnet_az_1 = "Enter Subnet AZ"
subnet_az_2 = "Enter Subnet AZ"
html_files = ["Enter all html, js, php files here"]
pics = ["Enter Pics here"]
  
}
