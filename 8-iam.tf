module "ecr_ci_myapp" {
 source = "trussworks/iam-ecr-ci/aws"

 ecr_repo = "lab-registry"
 ci_name  = "Jenkins"
}