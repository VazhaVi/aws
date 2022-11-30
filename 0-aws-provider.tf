
provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }
 backend "s3" {
   bucket         = "bog-terraform-state"
   encrypt        = true
   key            = "terraform.tfstate"
   region         = "eu-central-1"
   dynamodb_table = "terraform-state"
 }  

  required_version = "~> 1.0"
}

module "s3" {
    source = "./modules/s3"
    #bucket name should be unique
    bucket_name = "bog-terraform-state"     
    tf_dynamo_db_name = "terraform-state"  
}
