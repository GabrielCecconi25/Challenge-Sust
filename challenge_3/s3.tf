resource "aws_s3_bucket" "site" {
  bucket = "gabrielt-site"
}


resource "aws_s3_bucket_acl" "site" {
  bucket = aws_s3_bucket.site.id
  acl    = "public-read"
}


resource "aws_s3_bucket_versioning" "site" {
  bucket = aws_s3_bucket.site.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "site" {
  bucket = aws_s3_bucket.site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "site" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.allow_public_access.json

}

data "aws_iam_policy_document" "allow_public_access" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.site.arn}/*",
    ]
  }
}

resource "aws_s3_object" "index_page" {
  bucket       = aws_s3_bucket.site.id
  key          = "index.html"
  content_type = "text/html; charset=UTF-8"
  source       = "website/index.html"
  etag         = filemd5("website/index.html")
}

resource "aws_s3_object" "error_page" {
  bucket       = aws_s3_bucket.site.id
  key          = "error.html"
  content_type = "text/html; charset=UTF-8"
  source       = "website/error.html"
  etag         = filemd5("website/error.html")
}