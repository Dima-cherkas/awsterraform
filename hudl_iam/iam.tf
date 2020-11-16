
provider "aws" {
  region  = "us-west-2"
}

resource "aws_iam_user" "terraform_hudl" {
    name = "terraform_hudl"
}

resource "aws_iam_access_key" "terraform_hudl" {
  user    = aws_iam_user.terraform_hudl.name
  
}

resource "aws_iam_user_policy_attachment" "terraform_hudl" {
  for_each = toset([
    "arn:aws:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonECS_FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess"

  ])
  
  user       = aws_iam_user.terraform_hudl.name
  policy_arn = each.value
}

output "secret" {
  value = aws_iam_access_key.terraform_hudl.ses_smtp_password_v4
}