variable "aws_region" {
  description = "AWS region to deploy the infrastructure."
  type        = string
  default     = "eu-west-2"
}

variable "project_name" {
  description = "A name for the project."
  type        = string
}

variable "lambda_function_name" {
  description = "A name for the Lambda function."
  type        = string
}

variable "lambda_runtime" {
  description = "Runtime for the Lambda function."
  type        = string
  default     = "python3.8"
}

variable "lambda_handler" {
  description = "The Lambda function entry point."
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda_zip_file" {
  description = "Path to the zip file containing the Lambda function code."
  type        = string
}

variable "log_retention_days" {
  type        = number
  description = "The number of days to retain log events in the CloudWatch Logs Log Group."
  default     = 14
}
