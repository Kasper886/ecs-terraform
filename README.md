# AWS Elastic Container Service cluster creation

This repo creates AWS ECS fargate cluster with a simple web application, that works throw 80 and 443 ports (redirect from http to https protocol).

## Usage
You need credentials to your AWS account and terraform on board.
Also, go to variables.tf file and add your docker image to variable "app_image".

Then just run the following commands:
```
export AWS_ACCESS_KEY_ID=AKIAXXXXXXXXXXXXXXXX
export AWS_SECRET_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXXXX
export AWS_DEFAULT_REGION=us-east-1
```
```
git clone https://github.com/Kasper886/ecs-terraform.git
```
```
terraform init
```
```
terraform plan
```
```
terraform apply -auto-approve
```
When you finish and check all, simply destroy the infrastructure.
```
terraform destroy -auto-approve
```
