resource "aws_iam_role" "ec2_role" {
  name               = "${var.org_id}-ec2-role"
  path               = "/"
  assume_role_policy = local.ec2_assume_role_file
  tags = merge(
    {
      "Name" = format("%s-ec2-role", var.org_id)
    },
    local.web_tags
  )
}

resource "aws_iam_role_policy_attachment" "ec2_aws_policy" {
  count      = length(var.aws_ec2_policy_arn)
  role       = aws_iam_role.ec2_role.name
  policy_arn = var.aws_ec2_policy_arn[count.index]
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name     = "${var.org_id}-ec2-role"
  path     = "/"
  role     = aws_iam_role.ec2_role.name
}