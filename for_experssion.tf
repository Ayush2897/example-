# For Expressions
variable "names" {
    type = list
    default = ["daniel", "ada'", "john wick"]
}

output "show_names" {
    # similar to Python's list comprehension
    value = [for n in var.names : upper(n)]
}

output "short_upper_names" {
  # filter the resulting list by specifying a condition:
  value = [for name in var.names : upper(name) if length(name) > 7]
}


# Outputs:

short_upper_names = [
  "JOHN WICK",
]
show_names = [
  "DANIEL",
  "ADA'",
  "JOHN WICK",
]
***********************************************************************************************************************************
# Example 1: Filter Instances with Specific Tag

locals {
  instances = [
    { name = "instance-1", environment = "dev" },
    { name = "instance-2", environment = "prod" },
    { name = "instance-3", environment = "dev" },
  ]
}

output "dev_instance_names" {
  value = [for instance in local.instances : instance.name if instance.environment == "dev"]
}
# Result:

plaintext
Copy code
dev_instance_names = [
  "instance-1",
  "instance-3",
]
***********************************************************************************************************************************
Example 2: Create a List of Squared Numbers
hcl
Copy code
locals {
  numbers = [1, 2, 3, 4, 5]
}

output "squared_numbers" {
  value = [for num in local.numbers : num * num]
}
Result:

plaintext
Copy code
squared_numbers = [
  1,
  4,
  9,
  16,
  25,
]
***********************************************************************************************************************************
# Example 3: Extract Values from Map

locals {
  user_data = {
    alice = { age = 25, city = "New York" },
    bob   = { age = 30, city = "San Francisco" },
  }
}

output "user_ages" {
  value = { for name, info in local.user_data : name => info.age }
}
Result:

user_ages = {
  "alice" = 25,
  "bob"   = 30,
}
***********************************************************************************************************************************
# Example 5: Generate Dynamic Resource Names

locals {
  resource_names = [for i in range(1, 4) : "resource-${i}"]
}

output "resource_names" {
  value = local.resource_names
}
Result:

resource_names = [
  "resource-1",
  "resource-2",
  "resource-3",
]
***********************************************************************************************************************************
# Example 6: Concatenate Strings

locals {
  words = ["Terra", "form"]
}

output "phrase" {
  value = join(" ", local.words)
}
Result:

phrase = "Terra form"
***********************************************************************************************************************************
# Example 7: Convert List of Maps to a Map

locals {
  users = [
    { username = "alice", age = 25 },
    { username = "bob", age = 30 },
  ]
}

output "user_map" {
  value = { for user in local.users : user.username => user.age }
}
Result:

user_map = {
  "alice" = 25,
  "bob"   = 30,
}
***********************************************************************************************************************************
# Example 8: Filter Odd Numbers

locals {
  numbers = [1, 2, 3, 4, 5, 6]
}

output "even_numbers" {
  value = [for num in local.numbers : num if num % 2 == 0]
}
Result:

even_numbers = [
  2,
  4,
  6,
]
***********************************************************************************************************************************
# Example 9: Combine Lists

locals {
  list1 = [1, 2, 3]
  list2 = [4, 5, 6]
}

output "combined_list" {
  value = concat(local.list1, local.list2)
}
Result:

combined_list = [
  1,
  2,
  3,
  4,
  5,
  6,
]
***********************************************************************************************************************************
# Example 10: Generate Dynamic Block Labels

locals {
  services = ["web", "app", "db"]
}

resource "aws_instance" "example" {
  count = length(local.services)

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "instance-${local.services[count.index]}"
  }
}
Result:

aws_instance.example[0].tags = {
  "Name" = "instance-web"
}

aws_instance.example[1].tags = {
  "Name" = "instance-app"
}

aws_instance.example[2].tags = {
  "Name" = "instance-db"
}
***********************************************************************************************************************************