resource "aws_instance" "aws_instance" {
  ami                           = var.ami
  instance_type                 = var.instance_type
  key_name                      = var.key_name
  associate_public_ip_address   = var.associate_public_ip_address
  vpc_security_group_ids        = var.vpc_security_group_ids
  subnet_id                     = var.subnet_id
  tags                          = var.tags
  user_data                     = var.user_data
  root_block_device {
    volume_size = var.root_block_device_size
    volume_type = var.root_block_device_type
    delete_on_termination = true
  }
  provisioner "remote-exec" {
    inline = [
      "echo Waiting for user_data script to finish...",
      "while [ ! -f /var/log/user_data_completed ]; do sleep 5; done",
      "echo User_data script finished."
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = var.private_key
    }
  }
  provisioner "file" {
    source      = var.private_key_file
    destination = "/home/ubuntu/.ssh/id_rsa"
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = var.private_key
    }
  }
}
resource "aws_ebs_volume" "ebs_volume" {
  count             = var.aws_ebs_volume_needed == true ? 1 : 0
  availability_zone = aws_instance.aws_instance.availability_zone
  size              = var.ebs_block_device_size
  type              = var.ebs_block_device_type
  tags              = var.tags
}
resource "aws_volume_attachment" "ebs_volume_attachment" {
  count             = var.aws_ebs_volume_needed == true ? 1 : 0
  device_name       = "/dev/sdf"
  volume_id         = aws_ebs_volume.ebs_volume[count.index].id
  instance_id       = aws_instance.aws_instance.id
}
resource "null_resource" "mount_data_disk" {
  count             = var.aws_ebs_volume_needed == true ? 1 : 0
  provisioner "remote-exec" {
    inline = [
      "echo Waiting for user_data script to finish...",
      "while [ ! -f /var/log/user_data_completed ]; do sleep 5; done",
      "echo User_data script finished.",
      "echo Mounting EBS volume...",
      "sudo mkdir -p /mnt/data",
      "sudo mkfs -t ext4 /dev/xvdf",
      "sudo mount /dev/xvdf /mnt/data",
      "echo '/dev/xvdf /mnt/data ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab",
      "sudo chown -R ${var.ssh_user}:${var.ssh_user} /mnt/data"
    ]
    connection {
      type        = "ssh"
      host        = aws_instance.aws_instance.public_ip
      user        = var.ssh_user
      private_key = var.private_key
    }
  } 
}



# resource "aws_instance" "aws_instance" {
#   ami                           = var.ami
#   instance_type                 = var.instance_type
#   key_name                      = var.key_name
#   associate_public_ip_address   = var.associate_public_ip_address
#   vpc_security_group_ids        = var.vpc_security_group_ids
#   subnet_id                     = var.subnet_id
#   tags                          = var.tags
#   user_data                     = var.user_data
#   root_block_device {
#     volume_size = var.root_block_device_size
#     volume_type = var.root_block_device_type
#     delete_on_termination = true
#   }
# }
# resource "aws_ebs_volume" "ebs_volume" {
#   count             = var.aws_ebs_volume_needed == true ? 1 : 0
#   availability_zone = aws_instance.aws_instance.availability_zone
#   size              = var.ebs_block_device_size
#   type              = var.ebs_block_device_type
#   tags              = var.tags
# }
# resource "aws_volume_attachment" "ebs_volume_attachment" {
#   count             = var.aws_ebs_volume_needed == true ? 1 : 0
#   device_name       = "/dev/sdf"
#   volume_id         = aws_ebs_volume.ebs_volume[count.index].id
#   instance_id       = aws_instance.aws_instance.id
# }
# resource "null_resource" "mount_data_disk" {
#   count             = var.aws_ebs_volume_needed == true ? 1 : 0
#   provisioner "remote-exec" {
#     inline = [
#       "echo Waiting for user_data script to finish...",
#       "while [ ! -f /var/log/user_data_completed ]; do sleep 5; done",
#       "echo User_data script finished.",
#       "echo Mounting EBS volume...",
#       "sudo mkdir -p /mnt/data",
#       "sudo mkfs -t ext4 /dev/xvdf",
#       "sudo mount /dev/xvdf /mnt/data",
#       "echo '/dev/xvdf /mnt/data ext4 defaults,nofail 0 2' | sudo tee -a /etc/fstab",
#       "sudo chown -R ${var.ssh_user}:${var.ssh_user} /mnt/data"
#     ]
#     connection {
#       type        = "ssh"
#       host        = aws_instance.aws_instance.public_ip
#       user        = var.ssh_user
#       private_key = var.private_key
#     }
#   } 
# }