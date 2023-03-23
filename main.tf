module "get_method_api" {
  source              = "./get_method_api_module"
  // source              = "git::https://github.com/username/repo_name.git//path/to/module_folder?ref=<commit_sha>"
  aws_region          = "eu-west-2"
  project_name        = "my_get_method_api1"
  lambda_function_name = "my_get_method_lambda1"
  lambda_zip_file     = "path/to/lambda_function1.zip"
}
