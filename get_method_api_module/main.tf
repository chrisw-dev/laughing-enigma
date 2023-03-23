provider "aws" {
  region = var.aws_region
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.project_name}_lambda_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role       = aws_iam_role.lambda_role.name
}

resource "aws_lambda_function" "get_method_lambda" {
  function_name = var.lambda_function_name
  handler       = var.lambda_handler
  role          = aws_iam_role.lambda_role.arn
  runtime       = var.lambda_runtime

  filename = var.lambda_zip_file
}

resource "aws_api_gateway_rest_api" "get_method_api" {
  name = "${var.project_name}_api"
}

resource "aws_api_gateway_resource" "get_method_resource" {
  rest_api_id = aws_api_gateway_rest_api.get_method_api.id
  parent_id   = aws_api_gateway_rest_api.get_method_api.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.get_method_api.id
  resource_id   = aws_api_gateway_resource.get_method_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_method_lambda_integration" {
  rest_api_id = aws_api_gateway_rest_api.get_method_api.id
  resource_id = aws_api_gateway_resource.get_method_resource.id
  http_method = aws_api_gateway_method.get_method.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.get_method_lambda.invoke_arn
}

resource "aws_lambda_permission" "apigw_lambda_permission" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_method_lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_api_gateway_rest_api.get_method_api.execution_arn}/*/*"
}

resource "aws_api_gateway_deployment" "get_method_deployment" {
  depends_on = [aws_api_gateway_integration.get_method_lambda_integration]

  rest_api_id = aws_api_gateway_rest_api.get_method_api.id
  stage_name  = "prod"
}

