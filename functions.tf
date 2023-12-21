# 2. element - Access Element from List
hcl
Copy code
locals {
  fruits = ["apple", "orange", "banana", "grape"]
}

output "selected_fruit" {
  value = element(local.fruits, 2)
}
***********************************************************************************************************************************

map - Transform List Elements
hcl
Copy code
locals {
  numbers = [1, 2, 3, 4]
}

output "squared_numbers" {
  value = map(local.numbers, x => x * x)
}
Result:

plaintext
Copy code
squared_numbers = [
  1,
  4,
  9,
  16,


lookup - Retrieve Value from Map
hcl
Copy code
locals {
  user_info = {
    alice = { age = 25, city = "New York" },
    bob   = { age = 30, city = "San Francisco" },
  }
}

output "alice_age" {
  value = lookup(local.user_info["alice"], "age", "N/A")
}
Result:

plaintext
Copy code
alice_age = 25

format - Format Strings
hcl
Copy code
locals {
  username = "user"
  environment = "prod"
}

output "formatted_string" {
  value = format("%s-%s", local.username, local.environment)
}
Result:

plaintext
Copy code
formatted_string = "user-prod"

