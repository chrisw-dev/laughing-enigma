output "api_gateway_invoke_url" {
  value       = "https://${aws_api_gateway_rest_api.get_method_api.id}.execute-api.${var.aws_region}.amazonaws.com/prod"
  description = "The base URL to invoke the API Gateway"
}

output "lambda_function_name" {
  value       = aws_lambda_function.get_method_lambda.function_name
  description = "The name of the Lambda function"
}

output "lambda_function_arn" {
  value       = aws_lambda_function.get_method_lambda.arn
  description = "The ARN of the Lambda function"
}

output "cloudwatch_log_group_name" {
  value       = aws_lambda_function.get_method_lambda.name
  description = "The name of the CloudWatch Logs Log Group for the Lambda function"
}
