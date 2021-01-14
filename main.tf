provider "aws" {
  region = var.region
}

module "iam-user" {
  source = "./modules/iam-user"
  name = var.user_name
  region = var.region
  bucketprefix = var.bucketprefix
  pgpusername = var.pgpusername
}
