output "web_instance_ip" {
    value = aws_instance.web.public_ip
}

output "domain" {
    value = "https://${var.route_53_domain}"
}
