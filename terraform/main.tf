terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

data "aws_s3_bucket" "portfolio_bucket" {
  bucket = "ayush-portfolio-demo-12345"
}

resource "aws_s3_bucket_website_configuration" "portfolio_website_config" {
  bucket = data.aws_s3_bucket.portfolio_bucket.id
  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_public_access_block" "portfolio_bucket_public_access" {
  bucket = data.aws_s3_bucket.portfolio_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_public_read" {
  bucket = data.aws_s3_bucket.portfolio_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${data.aws_s3_bucket.portfolio_bucket.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.portfolio_bucket_public_access]
}

resource "aws_s3_object" "upload_html" {
  bucket       = data.aws_s3_bucket.portfolio_bucket.id
  key          = "index.html"
  source       = "../website/index.html"
  content_type = "text/html"
  etag         = filemd5("../website/index.html")
}

resource "aws_s3_object" "upload_css" {
  bucket       = data.aws_s3_bucket.portfolio_bucket.id
  key          = "styles.css"
  source       = "../website/style.css"
  content_type = "text/css"
  etag         = filemd5("../website/style.css")
}

resource "aws_s3_object" "upload_js" {
  bucket       = data.aws_s3_bucket.portfolio_bucket.id
  key          = "script.js"
  source       = "../website/script.js"
  content_type = "application/javascript"
  etag         = filemd5("../website/script.js")
}

resource "aws_s3_object" "upload_image" {
  bucket       = data.aws_s3_bucket.portfolio_bucket.id
  key          = "image.png"
  source       = "../website/image/profile.png"
  content_type = "image/png"
  etag         = filemd5("../website/image/profile.png")
}

output "website_url" {
  value       = aws_s3_bucket_website_configuration.portfolio_website_config.website_endpoint
  description = "The URL of the static website"
}