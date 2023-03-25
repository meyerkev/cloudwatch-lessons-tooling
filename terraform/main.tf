# use our lamdba module

module "lambda_function" {
    source = "terraform-aws-modules/lambda/aws"

    function_name = "cloudwatch-class-lambda"
    description   = "A simple logging lambda function"
    handler       = "logger.handler"
    runtime       = "nodejs18.x"
    timeout = 10

    source_path = "../js/logger.js"

    tags = {}

    store_on_s3 = true
    s3_bucket = module.s3_bucket.s3_bucket_id

    attach_policies = true
    policies =  [
        aws_iam_policy.lambda_cloudwatch_policy.arn
    ]
    number_of_policies = 1
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "cloudwatch-class-bucket"
  acl    = "private"

  versioning = {
    enabled = true
  }
}

resource "aws_iam_policy" "lambda_cloudwatch_policy" {
  name = "lambda_cloudwatch_policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
        ]
        Resource = "arn:aws:logs:*:*:*"
        Effect = "Allow"
      },
      {
        Action = [
          "cloudwatch:PutMetricData"
        ]
        Resource = "*"
        Effect = "Allow"
      }
    ]
  })
}