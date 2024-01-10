mock_data "aws_iam_policy_document" {
  defaults = {
    json = <<-EOT
      {
        "Version":"2012-10-17",
        "Statement":[
            {
              "Principal": "*",
              "Effect": "Allow",
              "Action": ["s3:GetObject"],
              "Resource": "arn:aws:s3:::test-bucket/*"
            }
        ]
      }
    EOT
  }
}