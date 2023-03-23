module "get_method_api" {
  source              = "./get_method_api_module"
  // source              = "git::https://github.com/chrisw-org/laughing-enigma/tree/main/get_method_api_module?ref=v0.0.1"
  aws_region           = "eu-west-2"
  project_name         = "my_get_method_api1"
  lambda_function_name = "my_get_method_lambda1"
  lambda_zip_file      = "path/to/lambda_function1.zip"
}
