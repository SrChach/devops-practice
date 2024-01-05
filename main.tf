resource "aws_s3_bucket" "exaple_bucket" {
    bucket = var.bucket_name

    tags = {
        Environment = var.environment
        Project = var.project_name
    }
}