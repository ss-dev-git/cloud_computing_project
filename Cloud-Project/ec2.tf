resource "aws_instance" "web" {
  ami             = var.ami_id  
  instance_type   = var.instance_type
  key_name        = var.instance_key
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.sg.id]
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_role.ec2_role.name
  user_data =<<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  sudo apt install php7.4 -y
  sudo yum -y install httpd && sudo systemctl start httpd
  sudo yum install mssql-server -y
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" 
  unzip -qq awscliv2.zip  
  ./aws/install -i /usr/local/aws-cli -b /usr/local/bin  
  aws --version
  aws s3 cp s3://${aws_s3_bucket.source_bucket.id}/  /var/www/html/ --recursive
  yum install system-config-firewall
  system-config-firewall
  echo "*** Completed Installing apache2"
  EOF

  tags = merge(
    {
      "Name" = format("%s-webserver", var.org_id)
    },
    local.web_tags
  )

lifecycle {
  ignore_changes = all
}
  volume_tags = {
    Name = "${var.org_id}-webserver"
  } 
}
