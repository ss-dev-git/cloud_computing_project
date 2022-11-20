resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.web_vpc.id

  tags = merge(
    {
      "Name" = format("%s-vpc-igw", var.org_id)
    },
    local.web_tags
  )
}