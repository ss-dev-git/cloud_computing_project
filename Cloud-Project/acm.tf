resource "aws_acm_certificate" "cert" {
  domain_name       = var.route_53_domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = merge(
    local.web_tags
  )
}

resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cert : record.fqdn]
}
