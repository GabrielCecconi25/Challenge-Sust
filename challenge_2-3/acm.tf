resource "aws_acm_certificate" "cert" {
    domain_name = var.root_domain
    validation_method = "DNS"

    subject_alternative_names = [var.root_domain, var.www_domain]
}

resource "aws_acm_certificate_validation" "valid_cert" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [for record in aws_route53_record.cetificate : record.fqdn]
}