resource "aws_security_group" "sg" {
  name        = "${var.org_id}-sg-1"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    {
      "Name" = format("%s-sg-1", var.org_id)
    },
    local.web_tags
  )

}

resource "aws_security_group" "alb_sg" {
  name        = "${var.org_id}-lb-sg"
  vpc_id      = aws_vpc.web_vpc.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = merge(
    {
      "Name" = format("%s-lb-sg", var.org_id)
    },
    local.web_tags
  )
}

resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.public_subnet_cidr1
  map_public_ip_on_launch = true
  availability_zone = var.subnet_az

  tags = merge(
    {
      "Name" = format("%s-public-subent-1", var.org_id)
    },
    local.web_tags
  )

}

resource "aws_subnet" "alb_sub1" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.public_subnet_cidr2
  map_public_ip_on_launch = true
  availability_zone = var.subnet_az_1

  tags = merge(
    {
      "Name" = format("%s-public-subent-2", var.org_id)
    },
    local.web_tags
  )
}

resource "aws_subnet" "alb_sub2" {
  vpc_id            = aws_vpc.web_vpc.id
  cidr_block        = var.public_subnet_cidr3
  map_public_ip_on_launch = true
  availability_zone = var.subnet_az_2
  tags = merge(
    {
      "Name" = format("%s-public-subent-3", var.org_id)
    },
    local.web_tags
  )
}

