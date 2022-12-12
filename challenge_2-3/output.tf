output "EIP" {
  value = aws_eip.eip.public_ip
}

output "Name_Server" {
  value = aws_route53_zone.main.name_servers
}

output "url" {
  value = aws_s3_bucket_website_configuration.site.website_endpoint
}


output "domain_cf" {
  value = aws_cloudfront_distribution.www_distribution.domain_name
}

output "vpc-eks" {
  value = aws_vpc.vpc2.id
}

output "SubeksPub-1a" {
  value = aws_subnet.sub2_01_pub.id
}

output "SubeksPub-1b" {
  value = aws_subnet.sub2_02_pub.id
}

output "SubeksPriv-1a" {
  value = aws_subnet.sub2_01_priv.id
}

output "SubeksPriv-1b" {
  value = aws_subnet.sub2_02_priv.id
}

output "sg_eks" {
  value = aws_security_group.sg_eks.id
}