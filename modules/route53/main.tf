
//SSL Certificate
resource "aws_acm_certificate" "mycert" {
  domain_name       = "${var.environment}.training.test-something.com"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }

  tags = var.myTags
}

# Rout53 Record
resource "aws_route53_record" "a53record" {
  for_each = {
    for rec in aws_acm_certificate.mycert.domain_validation_options : rec.domain_name => {
      name   = rec.resource_record_name
      record = rec.resource_record_value
      type   = rec.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  type            = each.value.type
  zone_id         = data.aws_route53_zone.myzone.zone_id
  ttl             = 60
}



data "aws_route53_zone" "myzone" {
  name         = "training.test-something.com"
  private_zone = false
}


resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.mycert.arn
  validation_record_fqdns = [for record in aws_route53_record.a53record : record.fqdn]

  timeouts {
    create = "5m"
  }
}

resource "aws_route53_record" "myrecord_53" {

  zone_id = data.aws_route53_zone.myzone.zone_id

  name = "${var.environment}.training.test-something.com"
  type = "A"

  alias {
    name                   = var.loadbalancer.dns_name
    zone_id                = var.loadbalancer.zone_id
    evaluate_target_health = false
  }

  depends_on = [aws_acm_certificate.mycert]
}
