resource "aws_s3_bucket" "example_bucket" {
    bucket = var.bucket_name

    tags = {
        Environment = var.environment
        Project = var.project_name
    }
}

resource "aws_s3_object" "initial_html_file" {
  bucket = aws_s3_bucket.example_bucket.id
  key = "hello-world"
  source = "demo-file.html"

  content_type = "text/html"
}
