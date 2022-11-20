resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.web_vpc.id

  route {
    cidr_block = var.cidr_block 
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    {
      "Name" = format("%s-public_rt", var.org_id)
    },
    local.web_tags
  )
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_asso1" {
  subnet_id      = aws_subnet.alb_sub1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rt_asso2" {
  subnet_id      = aws_subnet.alb_sub2.id
  route_table_id = aws_route_table.public_rt.id
}