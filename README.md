# Udrone Terraform

This terraform project deploy the base infrastucture for the UDrone project

## Motivation

Infrastucture as code is essential to be able to maintain, version and deploy a whole infrastucture faster and safer

## Requirements

+ [Terraform](https://terraform.io/)

## Installation or Getting Started

Please note that this project use Terraform Workspace to be able to deploy in dev, staging and production environment with the same code
Passwords are randomly generated and you won't be able to get them via this project, so you obviously need to change the resource group name if you wish to experiment.
	git clone git@ssh.dev.azure.com:v3/fsamiez-umanis/fsa-udrone-terraform/fsa-udrone-terraform
    cd fsa-udrone-terraform
    terraform plan
    terraform apply

## Contributors

If you wish to contribute, please contact me at fsamiez@umanis.com

## License

([MIT](http://opensource.org/licenses/mit-license.php))