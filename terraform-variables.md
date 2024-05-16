# Terraform Variables

terraform variables let you define values that can be reused throughout your
terraform configuration, similar to variables in any proramming language

they make configuration more dynamic and flexiblem, and they enhance parameterization
of your code.

## Terraform Variable Types

* String

this fundamental type stores text values.  using string for data that doesn't require
mathematical operations, such as usernames or tags

* Number

this type is used for numeric values that you might need to perform calculations
on or use in numberic settings, such as scaling parameters, setting timeouts and
defining a number of instances to deploy

* Bool

short for boolean, this type is strickly for true or false, they are essential for
logic and conditional statements in configurations, such as enabling or disabling
resource provisioning

* List

a sequence of values of the same type, this is ideal for scenarios where you need
to manage a collection of similar items, like multiple configuration tags

* Map

are collections of key-value pairs, each unique key mapping to a specific value,
this type is useful, for example: when associating server names with their roles
or configurations

* Tuple

similar to lists but can contain a fixed number of elements, each potentially of
a different type. suitable for when you need to group a specific set of values with
varied types together, like a coordinate of mixed data types

* Object

used to define a structure with named attributes, each with its own type. they are 
very flexible, allowing the definition of complex relationships, like a configuration
block that includes various attributes of different types

* Set

sets are collections of unique values of the same type, they are useful when you need
to ensure no duplicates, such as a list of unique user identifiers or configurations that
must remain distinct

## Local Variables

local variables are declared using the `locals` block, it's a group of key value
pairs that can be used in the configuration.  the values can be hard coded or be a 
reference to another variable or resource

local variables are accessible within the module/configuration where they are declared

example: VM instance using local variables, add the this to a file named main.tf

* main.tf
```tf

locals {
  ami = "ami-0d26eb3972b7f8c96"
  type = "t2.micro"
  tags = {
    Name = "My Virtual Machine"
    Env = "Dev"
  }
  subnet = "subnet-76a8163a"
  nic = aws_network_interface.my_nic.id
}

resource "aws_instance" "myvm" {
  ami = local.ami
  instance_type = local.type
  tags = local.tags

  network_interface {
    network_interface_id = aws_network_interface.my_nic.id
    device_index = 0
  }
}

resource "aws_network_interface" "my_nic" {
  description = "My Nic"
  subnet_id = var.subnet

  tags = {
    Name = "My Nic"
  }
}
```

in this example, we have declared all the local variables in the locals block.
the variables represent the AMI ID (`ami`), Instance type (`type`), Subnet Id (`subnet`),
Network Interface (`nic`), and Tags (`tags`) to be assigned for the given EC2 instance

in the `aws_instance` we used the resource block.
notice how the variables are being referenced usinge a `local` keyword (without s)

the usage of local variables is similar to data sources, we can set our values in
local variables - they are not dependent on cloud providers

best practice is to keep local variables to a minimum

## Terraform Input Variables

input variables are used to pass certain values from outside of the configuration
or module, they are used to assign dynamic values to resource attributes

the difference between local and input variables is that input variables allow
you to pass values before code execution

the main function of input variables is to act as inputs to modules.

modules are self-contained pieces of code that perform certain predefined deployment
tasks

input variables declared within modules are used to accept values from the root
directory

it is possible to set certain attributes while declaring input variables

* type

to identify the type of variable being declared

* default

default value in case the value is not provided explicitly

* description

a description of the variable.  this description is used to generate documentation
for the module

* validation

to define validation rules

* sensitive

a boolean value, if true, terraform masks the variable's value anywhere it displays
the variable

## Terraform input variable types

input variables support multiple data types

they are broadly categorized as simple and complex.

* Simple data types: string, number, bool

* Complex data types: list, map, tuple, object and set

### String Type

used to accept values in the form of UNICODE character, the value is usually wrapped
by double quotes

```tf
variable "string_type" {
  description = "This is a variable type of string"
  type = string
  default = "Default string value for this variable"
}
```

string type input also support a heredoc style format where the value being accepted
is a longer string seperated by new line characters

the start of the value is indicated by "EOF" end of file charaters

```tf
variable "string_heredoc_type" {
  description = "This is a variable of type string"
  type = string
  default = <<EOF
hello, this is Serge.
Do visit my website!
EOF
}
```

### Number Type

enables us to define and accept numerical values as inputs for their infrastructure
deployments

ex: these numeric values can help define the desired number of instances to be created
in an auto-scaling group

```tf
variable "number_type" {
  description = "This is a variable of type number"
  type = number
  default = 42
}
```

### Boolean Type

used to define and accept true/false values as inputs

are useful for enabling or disabling certain features or behaviors in infrastructure
deployments

```tf
variable "boolean_type" {
  description = "This is a variable type bool"
  type = bool
  default = true
}
```

### List variables

allows us to define and accept a collection of values as inputs for infrastructure
deployments

a list is an ordered sequence of elements, and can contain any data type such as
strings, numbers, or even complex data structures

a single list cannot have multiple data types

useful in scenarios where we need to provide multiple values of the same type,
such as a list of IP addresses, a set of ports, or a collection of resource names

```tf
variable "list_type" {
  description = "This is a variable of type list"
  type = list(string)
  default = ["string1", "string2", "string3"]
} 
```

### Map type

enables us to define a collection of key-value pair as inputs.  a complex data
structure that associates values with unique keys similar to a dictionary or
an object in other programming languages

can be used to specify resource tags, environment-specific settings, or configuration
parameters for different modules

```tf
variable "map_type" {
  description = "This is a variable of type map."
  type = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}
```

### Object type

complex data structure that consists of multiple key-value pairs, where each key
is associated with a specific data type for its corresponding value

```tf
variable "object_type" {
  description = "This is a variable of type object"
  type = object({
    name = string
    age = number
    enabled = bool
  })
  default = {
    name = "John Doe"
    age = 30
    enabled = true
  }
}
```

### Tuple type

a fixed-length collection that can contain values of different dat types, the key
difference between tuples and lists are:

1. tuples have a fixed length, as against lists
2. with tuples, it is possible to include values with different primitive types,
meanwhile lists dictate the type of elements included in them

3. values included in tuples are ordered. due to their dynamic sizes, it is possible
to resize and reorder the values in lists

```tf
variable "tuple_type" {
  description = "This is a variable of type tuple"
  type = tuple([string, number, bool])
  default = ["item", 42, true]
}
```

### Set type

an unordered collection of distinct values, meaning each element appear only once
with the set.

compared to lists, sets enforce uniqueness - each element can only appear one within
the set

sets supports various inbuilt operations such as unions, intersection, and difference
which are used to combine or compare sets

```tf
variable "set_example" {
  description = "This is a variable of type set"
  type = set(string)
  default = ["item1", "item2", "item3"]
}
```

### Map of objects

one of the widely used complex input variable.  it is a data type that represents
a map where each key is associated with an object value

it allows us to create a collection of key-value pairs, where the values are object
with defined attributes and their respective values

when using map(object), we define the structure of the object values by specifying
the attributes and their corresponding types within the object type definition

each object with the map has its own sets of attributes, providing flexibility to
represent sets of data

```tf
variable "map_of_objects" {
  description = "This is a vriable of type Map of objects"
  type = map(object({
    name = string,
    cidr = string
  }))
  default = {
    "subnet_a" = {
      name = "subnet-a",
      cidr = "10.10.1.0/24"
    },
    "subnet_b" = {
      name = "subnet-b",
      cidr = "10.10.2.0/24"
    },
    "subnet_c" = {
      name = "subnet-c"
      cidr = "10.10.3.0/24"
    }
  }
}
```

### List of objects

this type of variable is similar to the Map of objects, except the objects are not 
referred to by any "key"

the list(object) is an ordered list of objects where each object is referred to 
using the index.  

on the other hand, map(object) is an unordered set, and each object is referred to
using the key value

```tf
variable "list_of_objects" {
  description = "This is a variable of type List of objects"
  type = list(object({
    name = string,
    cidr = string
  }))
  default [
    {
      name = "subnet-a",
      cidr = "10.10.1.0/24"
    },
    {
      name = "subnet-b",
      cidr = "10.10.2.0/24"
    },
    {
      name = "subnet-c",
      cidr = "10.10.3.0/24"
    }
  ]
}
```

## Terraform input variables example

* variables.tf
```tf
variable "ami" {
  type = string
  description = "AMI ID for the EC2 instance"
  default = "ami-0d26eb3972b7f8c96"

  validation {
    condition = length(var.ami) > && substr(var.ami, 0, 4) == "ami-"
    error_message = "Please provide a valid value for variable AMI."
  }
}

variable "type" {
  type = string
  description = "Instance type for the EC2 instance"
  default = "t2.mirco"
  sensitive = true
}

variable "tags" {
  type = object({
    name = string
    env = string
  })
  description = "Tags for the EC2 instance"
  default = {
    name = "My Virtual Machine"
    env = "Dev"
  }
}

variable "subnet" {
  type = string
  description = "Subnet ID for network interface"
  default = "subnet-76a8163a"
}
```

we declared 5 variables - `ami`, `nic`, `subnet`, and `type` with the sample data
type and `tags` with a complex data type object - a collection of key-value pairs
with string values

notice how we made use of attributes like `description` and `default`

modify the main.tf to use the variables above

* main.tf

```tf
resource "aws_instance" "myvm" {
  ami = var.ami
  instance_type = var.type
  tags = var.tags

  network_interface {
    network_interface_id = aws_network_interface.my_nic.id
    device_index = 0
  }
}

resource "aws_network_interface" "my_nic" {
  description "My NIC"
  subnet_id = var.subnet

  tags = {
    Name = "My NIC"
  }
}
```

within the resource blocks we simply used these variables by using `var.<variable name>`
format

when you proceed to apply the configuration the variable values will automatically
be replaced by default values.

notice how the `type` value is represented in the plan output, since we have marked
it as `sensitive` its value is not shown instead, it just displays `sensitive`

## Variable Substitution using CLI and .tfvars

* passing the values in CLI as -var argument

if we want to initialize the variables using the CLI argument, ex. below

```shell
$ terraform plan -var "ami=test" -var "type=t2.nano" -var "tags={\"name\":\"My Virtual Machine\",\"env\":\"Dev\"}"
```
passing variables using CLI arguments can become a tedious task. this is where
.tfvars files come into play

create a file with the .tfvars extension

use the values.tfvars or use terraform.tfvars

* values.tfvars
```js
ami = "ami-0d26eb3972b7f8c96"
type = "t2.nano"
tags = {
  "name" : "My Virtual Machine"
  "env" : "Dev"
}
```
this time you should as terraform to use the `values.tfvars` file by providing its
path to -var-file CLI argument.  

```shell
$ terraform plan -var-file values.tfvars
