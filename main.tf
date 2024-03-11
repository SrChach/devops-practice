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

resource "aws_s3_object" "initial_html_file" {
  bucket = aws_s3_bucket.example_bucket.id
  key    = "hello-world.html"
  source = "demo-file.html"

  content_type = "text/html"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.example_bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.catalog-writer.arn
    events              = ["s3:ObjectCreated:*"]
    filter_suffix       = ".png"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}
