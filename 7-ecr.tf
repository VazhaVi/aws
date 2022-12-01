module "ecr" {
  source  = "terraform-module/ecr/aws"
  version = "1.0.5"

  ecrs = {
    lab-registry = {
      tags = { Service = "api" }
      lifecycle_policy = {
        rules = [{
          rulePriority = 1
          description  = "keep last 50 images"
          action = {
            type = "expire"
          }
          selection = {
            tagStatus   = "any"
            countType   = "imageCountMoreThan"
            countNumber = 50
          }
        }]
      }
    }
  }
}