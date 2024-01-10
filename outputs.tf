output "endpoint" {
  description = "URL endpoint of the website."
  value       = "http://${aws_s3_bucket_website_configuration.www_bucket.website_endpoint}"
}

output "product" {
  description = "The product which was randomly selected."
  value       = local.hashi_products[random_integer.product.result].name
}

output "cloudfront_url" {
  value = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}"
}
