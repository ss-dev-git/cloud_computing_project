resource "aws_vpc" "web_vpc" {
  cidr_block = var.vpc_cidr

  tags = merge(
    {
      "Name" = format("%s-vpc", var.org_id)
    },
    local.web_tags
  )

}