variable "ami" {}
variable "instance_type" {}
variable "key_name" {}
variable "associate_public_ip_address" {}
variable "vpc_security_group_ids" {}
variable "subnet_id" {}
variable "tags" {}
variable "user_data" {}
variable "root_block_device_size" {
    default = 8
}
variable "root_block_device_type" {
    default = "gp2"
}
variable "ebs_block_device_size" {
    default = 2
}
variable "ebs_block_device_type" {
    default = "gp2"
}
variable "aws_ebs_volume_needed" {
    default = false
}
variable "private_key" {
    default = null
}
variable "ssh_user" {
    default = "ubuntu"
}
variable "private_key_file" {
    default = "./private_key.pem"
}
 



# variable "ami" {}
# variable "instance_type" {}
# variable "key_name" {}
# variable "associate_public_ip_address" {}
# variable "vpc_security_group_ids" {}
# variable "subnet_id" {}
# variable "tags" {}
# variable "user_data" {
#   default       = ""
#   description   = "Path to the user data script to be executed on instance launch."
#   type          = string
# }

# variable "ami" {}
# variable "instance_type" {}
# variable "key_name" {}
# variable "associate_public_ip_address" {}
# variable "vpc_security_group_ids" {}
# variable "subnet_id" {}
# variable "tags" {}
# variable "user_data" {}
# variable "root_block_device_size" {
#     default = 8
# }
# variable "root_block_device_type" {
#     default = "gp2"
# }
# variable "ebs_block_device_size" {
#     default = 2
# }
# variable "ebs_block_device_type" {
#     default = "gp2"
# }
# variable "aws_ebs_volume_needed" {
#     default = false
# }
# variable "private_key" {
#     default = null
# }
# variable "ssh_user" {
#     default = "ubuntu"
# }