# use our lamdba module

module "lambda_function" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "cloudwatch-class-lambda"
  description   = "A simple logging lambda function"
  handler       = "logger.handler"
  runtime       = "nodejs18.x"

  source_path = "../js/logger.js"

  tags = {}
}