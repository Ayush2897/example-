# Example 1: Creating EC2 Instances with Unique Names

variable "instance_names" {
  default = {
    instance1 = "t2.micro",
    instance2 = "t2.nano",
    instance3 = "t2.small",
  }
}

resource "aws_instance" "example" {
  for_each = var.instance_names

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = each.value

  tags = {
    Name = each.key
  }
}
***********************************************************************************************************************************
# Example 2: Managing Security Groups

variable "security_groups" {
  default = {
    web  = ["80", "443"],
    app  = ["8080", "8443"],
    db   = ["3306"],
  }
}

resource "aws_security_group" "example" {
  for_each = var.security_groups

  name        = each.key
  description = "Security Group for ${each.key}"

  ingress {
    from_port = tonumber(each.value[0])
    to_port   = tonumber(each.value[1])
    protocol  = "tcp"
  }
}
***********************************************************************************************************************************
# Example 3: Creating S3 Buckets

variable "buckets" {
  default = ["data", "logs", "backups"]
}

resource "aws_s3_bucket" "example" {
  for_each = toset(var.buckets)

  bucket = each.value
  acl    = "private"
}
***********************************************************************************************************************************
# Example 4: Managing IAM Users

variable "users" {
  default = {
    alice = { name = "Alice", groups = ["developers"] },
    bob   = { name = "Bob", groups = ["admins"] },
  }
}

resource "aws_iam_user" "example" {
  for_each = var.users

  name = each.value.name
}

resource "aws_iam_user_group_membership" "example" {
  for_each = var.users

  user    = aws_iam_user.example[each.key].name
  groups  = each.value.groups
}

***********************************************************************************************************************************
# Example 5: Creating Route 53 Records
hcl
Copy code
variable "dns_records" {
  default = {
    www   = { type = "A", ttl = 300, records = ["10.0.0.1"] },
    app   = { type = "CNAME", ttl = 300, records = ["app.example.com"] },
  }
}

resource "aws_route53_record" "example" {
  for_each = var.dns_records

  zone_id = "Z0123456789ABCDEF012345"
  name    = each.key
  type    = each.value.type
  ttl     = each.value.ttl

  records = each.value.records
}
***********************************************************************************************************************************
# Example 6: Creating AWS Lambda Functions

variable "lambda_functions" {
  default = {
    func1 = { runtime = "nodejs14.x", handler = "index.handler" },
    func2 = { runtime = "python3.8", handler = "main.handler" },
  }
}

resource "aws_lambda_function" "example" {
  for_each = var.lambda_functions

  function_name = each.key
  runtime       = each.value.runtime
  handler       = each.value.handler

  # other function configuration...
}
***********************************************************************************************************************************
# Example 7: Managing GitHub Teams

variable "github_teams" {
  default = {
    developers = { description = "Developers team" },
    ops        = { description = "Operations team" },
  }
}

resource "github_team" "example" {
  for_each = var.github_teams

  name        = each.key
  description = each.value.description
}
***********************************************************************************************************************************