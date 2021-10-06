provider "aws" {
  shared_credentials_file = "${var.shared_credentials_file}"
  #instead of shared_credentials_file you can use
  #access_key = "add-your-key"
  #secret_key = "add-your-access_key"
  
  region     = var.aws_region
    
  #if you are running from AWS ec2 linux instance please use bellow credentials section
  #shared_credentials_file = "$HOME/.aws/credentials"
  #profile = "default"
}
