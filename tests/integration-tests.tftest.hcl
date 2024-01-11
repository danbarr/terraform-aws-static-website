variables {
  prefix     = "tftest"
  region     = "us-east-2"
  env        = "test"
  department = "PlatformEng"
}

provider "aws" {
  region = "us-east-2"
}

run "create_bucket" {
  command = apply

  override_resource {
    target = aws_cloudfront_distribution.s3_distribution
    values = {
      domain_name = "testwebsite.example.com"
    }
  }

  assert {
    condition     = startswith(aws_s3_bucket.www_bucket.bucket, "tftest-hashicafe-website-test-")
    error_message = "The bucket name does not start with the expected prefix."
  }

  assert {
    condition     = aws_cloudfront_distribution.s3_distribution.domain_name == "testwebsite.example.com"
    error_message = "The CloudFront domain name does not match the expected value."
  }
}

run "website_is_running" {
  command = plan

  module {
    source = "./tests/http-validate"
  }

  variables {
    endpoint = run.create_bucket.endpoint
  }

  assert {
    condition     = data.http.index.status_code == 200
    error_message = "Website responded with HTTP status ${data.http.index.status_code}"
  }
}
