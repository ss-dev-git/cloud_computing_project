locals {
  web_tags = merge(
    {
      "Org" = format("%s",var.org_id)
    },
    {
      "CreatedBy" = format("Terraform")
    }
  )


  ec2_assume_role_file  = templatefile("${path.module}/json_templates/ec2.json", {})
}

