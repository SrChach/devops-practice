locals {
  whitelist_cidr = ["0.0.0.0/0"]
}

resource "aws_s3_bucket" "example_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_iam_policy_document" "main_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.example_bucket.arn}/*"
    ]
    condition {
      test     = "IpAddress"
      variable = "aws:SourceIp"
      values   = local.whitelist_cidr
    }
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "main_policy_bucket" {
  bucket = aws_s3_bucket.example_bucket.id
  policy = data.aws_iam_policy_document.main_policy.json
}

resource "aws_s3_object" "initial_html_file" {
  bucket = aws_s3_bucket.example_bucket.id
  key    = "hello-world"
  source = "demo-file.html"

  content_type = "text/html"
}
