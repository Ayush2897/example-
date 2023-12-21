***********************************************************************************************************************************
# 1. Creating Multiple Instances of a Resource
resource "aws_instance" "example" {
  count = 3

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance-${count.index + 1}"
  }
}
***********************************************************************************************************************************
# 2. Conditional Resource Creation
variable "create_instance" {
  default = true
}

resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0

  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
***********************************************************************************************************************************
# 3.Using Count with Modules

# root module - variables.tf
variable "sandboxes" {
  type    = list(string)
  default = ["sandbox_server_one", "sandbox_server_two", "sandbox_server_three"]
}

# root module - main.tf
module "web_servers" {
  source = "./modules/web_servers"

  count         = 3
  instance_type = "t2.micro"
  nameTag       = var.sandboxes[count.index]
}
***********************************************************************************************************************************
# 4.length
variable "sandboxes" {
  type    = list(string)
  default = ["sandbox_server_one", "sandbox_server_two", "sandbox_server_three"]
}

# main.tf
resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = length(var.sandboxes)
  tags = {
    Name = var.sandboxes[count.index]
  }
}
***********************************************************************************************************************************
# 5.var.instance_type == “t2.micro” ? 1 : 0 if the instance_type is not t2.micro, it will evaluate to 0 and no instance will be created.
# variables.tf
variable "ami" {
  type    = string
  default = "ami-0078ef784b6fa1ba4"
}

variable "instance_type" {
  type = string
  default = "t2.small"
}

# main.tf
resource "aws_instance" "dev" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = var.instance_type == "t2.micro" ? 1 : 0
  tags = {
    Name = "dev_server"
  }
}
***********************************************************************************************************************************