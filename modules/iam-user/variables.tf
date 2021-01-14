variable "name" {
  description = "Desired name for the IAM user"
  type        = string
}

variable "region" {
  description	= "Region name"
  type		= string
}

variable "bucketprefix" {
  description   = "Bucket Prefix"
  type          = string
}

variable "pgpusername" {
  description   = "PGP User Name"
  type          = string
}
