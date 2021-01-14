output "user_name" {
 value = aws_iam_user.usr.name
}

output "user_id" {
 value = aws_iam_access_key.usr.id
}

output "password" {
 value = aws_iam_access_key.usr.ses_smtp_password_v4
}

output "secret" {
 value = aws_iam_access_key.usr.encrypted_secret
}
