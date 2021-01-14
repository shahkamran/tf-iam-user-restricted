# Create IAM User account
resource "aws_iam_user" "usr" {
  name = var.name
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

# Create IAM Access Key
resource "aws_iam_access_key" "usr" {
  user    = aws_iam_user.usr.name
  pgp_key = "keybase:${var.pgpusername}"
}

# Create Login Profile
resource "aws_iam_user_login_profile" "usr" {
  user    = aws_iam_user.usr.name
  pgp_key = "keybase:${var.pgpusername}"
}

# Attach Permission Policy to User Account
resource "aws_iam_user_policy" "usr_s3_restricted" {
  name = "S3access-specific-bucket"
  user = aws_iam_user.usr.name

  # This section uses data block for json policy definition

  policy = data.aws_iam_policy_document.usr_s3_restricted.json

  # This section uses in-line policy statement rather than above data block json policy

  #
  #  policy = <<EOF
  #{
  #    "Version": "2012-10-17",
  #    "Statement": [
  #        {
  #            "Effect": "Allow",
  #            "Action": "s3:GetBucketLocation",
  #            "Resource": "arn:aws:s3:::winnershawsk8gurus2021*"
  #        },
  #        {
  #            "Effect": "Allow",
  #            "Action": "s3:ListBucket",
  #            "Resource": "arn:aws:s3:::winnershawsk8gurus2021*"
  #        },
  #        {
  #            "Effect": "Allow",
  #            "Action": "s3:ListAllMyBuckets",
  #            "Resource": "*"
  #        },
  #        {
  #            "Effect": "Allow",
  #            "Action": "s3:*",
  #            "Resource": [
  #                "arn:aws:s3:::winnershawsk8gurus2021*"
  #                ],
  #            "Condition": {
  #                "StringEquals": {
  #                    "aws:RequestedRegion": "eu-west-2"
  #                }
  #            }
  #        }
  #    ]
  #}
  #EOF
}

data "aws_iam_policy_document" "usr_s3_restricted" {
  statement {
    sid    = "allowgetbucketlistv1"
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation",
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::${var.bucketprefix}*",
    ]
  }

  statement {
    sid    = "allowlistallbucketsv1"
    effect = "Allow"
    actions = [
      "s3:ListAllMyBuckets",
    ]
    resources = [
      "*",
    ]
  }

  statement {
    sid    = "allowregionalbucketactionsv1"
    effect = "Allow"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.bucketprefix}*",
    ]
    condition {
      test     = "StringEquals"
      variable = "aws:RequestedRegion"
      values = [
        var.region,
      ]
    }
  }
}

