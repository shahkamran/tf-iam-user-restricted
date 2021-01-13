provider "aws" {
  region = "eu-west-2"
}

###################################################################
# IAM user without pgp_key (IAM access secret will be unencrypted)
###################################################################
#module "iam_user2" {
#  source = "./modules/iam-user"
#
#  name = "tk8supportuser"
#
#  create_iam_user_login_profile = false
#  create_iam_access_key         = true
#}


resource "aws_iam_user" "usr" {
  name = "tk8supportuser"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_access_key" "usr" {
  user = aws_iam_user.usr.name
  pgp_key = "keybase:kamran"
}

resource "aws_iam_user_policy" "usr_ro" {
  name = "S3access-specific-bucket"
  user = aws_iam_user.usr.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:GetBucketLocation",
            "Resource": "arn:aws:s3:::winnershawsk8gurus2021*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::winnershawsk8gurus2021*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:ListAllMyBuckets",
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::*/*",
                "arn:aws:s3:::winnershawsk8gurus2021*"
                ],
            "Condition": {
                "StringEquals": {
                    "aws:RequestedRegion": "eu-west-2"
                }
            }

        }
    ]
}

EOF
}  
